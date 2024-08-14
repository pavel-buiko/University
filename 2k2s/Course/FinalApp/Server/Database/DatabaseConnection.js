const oracledb = require('oracledb');

const dbConfig = {
    user: 'hr',
    password: '1111',
    connectString: "localhost:1521/xepdb1"
};

let connection;

async function connectToDB() {
    if (!connection) {
        try {
            connection = await oracledb.getConnection(dbConfig);
            console.log("Connected to Oracle Database");
        } catch (err) {
            console.error("Error connecting to Oracle Database: ", err);
            throw err;
        }
    }
    return connection;
}

module.exports = {
    connectToDB
};
