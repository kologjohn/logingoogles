const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();

// Listen for changes in the Realtime Database 'transactions' node
exports.transactionsApi = functions.database.ref('/transactions').onWrite((change, context) => {
    const data = change.after.val();
    const transactions = Object.keys(data).map(key => {
        return { id: key, ...data[key] };
    });

    // Update Firestore collection 'transactions'
    const firestoreBatch = admin.firestore().batch();
    transactions.forEach(transaction => {
        const transactionRef = admin.firestore().collection('transactions').doc(transaction.id);
        firestoreBatch.set(transactionRef, transaction);
    });

    // Commit the batch
    return firestoreBatch.commit()
        .then(() => {
            console.log('Transactions added to Firestore collection.');
            return null;
        })
        .catch(error => {
            console.error('Error adding transactions to Firestore:', error);
            return null;
        });
});

// Create an HTTP function to serve the transactions as an API
exports.getTransactions = functions.https.onRequest((request, response) => {
    admin.firestore().collection('transactions').get()
        .then(snapshot => {
            const transactions = [];
            snapshot.forEach(doc => {
                transactions.push(doc.data());
            });
            response.json(transactions);
            return null;
        })
        .catch(error => {
            console.error('Error fetching transactions:', error);
            response.status(500).send('Internal Server Error');
        });
});
