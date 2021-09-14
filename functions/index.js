const admin = require('firebase-admin');
const functions = require('firebase-functions');
const { GoogleSpreadsheet } = require('google-spreadsheet');
// Create and Deploy Your First Cloud Functions
// https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });

admin.initializeApp();

exports.firestoreToCsv = functions.https.onRequest(
  async (request, response) => {
    const stuff = [];
    const db = admin.firestore();
    const snapshot = await db.collection('instructors').get();
    snapshot.forEach((doc) => {
      stuff.push(doc.data());
    });
    response.send(stuff);
  }
);

exports.googleSheetToFirestore = functions.https.onRequest(async (req, res) => {
  try {
    const db = admin.firestore();

    const doc = new GoogleSpreadsheet(
      '13bugA_F8HQDgQ8jMqwr5kkNMfq7kWsAD-Ma_DXgyp5w'
      // '1Bw9XFCn45IoNOEY-SPrUSB7gs9NDCSOor4H64Rrd8rM'
      //   '1B-gTS0oPC3GEvn6D1YXyd_JGDkw2LOGDtoBWJYHRPTI'
    );

    await doc.useServiceAccountAuth({
      client_email:
        // 'google-sheet-reader@pc-api-5986142305463284031-314.iam.gserviceaccount.com',
        'causewell@appspot.gserviceaccount.com',
      private_key:
        '-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDC1sIJjMGvz+ti\nrvEh1dOPjGC+Kew8HHFHtOnSMCG+tmTtUIPGd4POd3BE+4rFZHw1ESo2WNjRRTIw\nnE+riAndznb9I85WxigtgQHvza5xhqZ/Ag2bdKkF3PeWp+bgJIxRYSI7C7qeXLpo\njb9aTEuTVGCNUvOuUv9O1+w2mN/wN2i5j8PgFsykNk45NC4yXnvDJqQXEtOsA3vi\nT6UoYxD93Ayr17MsEgXE1UkK3vrWMGXLFbs8gmYZ/AukLL9spgwSsIranSpCz4jw\n3wq/87tbKtRF08BIpu97XXcMUf6bic2JN24mj/00Btvp80DLGeTo2j52O2COCsQr\nl3Hg4EYnAgMBAAECggEAYJmzuKJmAXIX5WSRP1JRwzE5Ye9NJfyAGapT55dfk7vA\nzHyH6SWmXv6O1lTU18tbXcA16p4gWZlyKfHF+mjHY4aTLizLh/BVSUJWIHwcykKV\nWBE/h9zOVI7a3oI+kNDuFQcQvq+xBgU5ks78mZuMOO6ztD31fW+/D2s0vVkMZn9j\nVYbIIcihi23WCzEWaXl9rrR/nqxbIFx/AxMK0uHMUe6tNA+usBPQLwdsxWcHoat2\nLlQcFk1MuGYAF5xHFtxz2RKK9G5w4Z2H5THoHXz0YImm1XYf2nem/t1MrLIjBiZO\nuy6kzHl4TQPoMIZZSZm7LL19oXL/DRvNuyHM5vziEQKBgQD7WXXp0pGgdMXt4XQg\nmlmo8oq49aemKE0JDNqNsF6BVPagxAUdZ0A/g5O/ne5HeguzMAAJv3inygM/kkxs\nf/ZylE0iBfNo+ZzpASyzUh6VxIJ5TFtu0kqWdD0CNkVVJ9hSlMHRtJrpv6QkoVYZ\nQ9rkO94RC5LgHKZjlBlFmAZL2QKBgQDGcaFHsfLpS5wjasy3mCFBljQTYY0CmhVD\ny0EP4+MRS/O+Z5dQ72pJZVHMw/YOzTNogk/jsBCY/mYZ6+oGXe3Pu963sibRWZkI\n79UHVPWRg4s7qfmcnKGOy5v/LUZwI/2UsMVv/DOMHqgd+mIA0i/41TE6pzdaWVb+\nKCPgN9nh/wKBgQCpNN1rToUYxuPkM21w8VfAo579yupUsjbCC/QphHzqhh8NtUhY\nNgULfPF/ArvBRIkR1ROBfHOmSRmMt1lZhX+MPQf8CpOFrNyUA2VrRrIuUr8fF2dK\nIKlzxca4cX6VSCCZ32jnWrUa/RdsTWxfz81Q7nidcvQqiT7+NFoa/q/maQKBgQCl\nu5Tk2dtzuDAI7FNZKfbsXdPUM+6es6z616/Y44xqj7Jb3QxlDe8IqVPt3eOMbRh4\nOg0arZrPC/idwYfMFXpduhvB80m0Ik5LRnH2E6CcDO6lv8m2YKIVLjt0nI1tbsGE\nAzaB1nH+nkPt9YUQBnsGKJda0vjJvj+HOGLuCfcwZQKBgQCU7wn+ymt9e/VZGGLC\n0rVcc+6U0jqpuXxorqM3zh9D3iH4KEhbxahOsAWdWRoNicamI8UFF1KzyEwpg/IP\nx5ZeBHHqdSnaN3m7e4JVIk0iUWr7+97GNPQ1XgNdJ1YGUpPyOtgKGFTbSMmXJbBU\nr2PpOXvi6ZJ5Ta4/OyIXOQDD9Q==\n-----END PRIVATE KEY-----\n',
    });

    await doc.loadInfo();
    // console.log(`>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ${doc.title}`);
    // await doc.updateProperties({ title: 'Causewell' });

    const sheet = doc.sheetsByIndex[0];
    const rows = await sheet.getRows();
    let courses = [];

    rows.forEach(async (row) => {
      let data = {};
      const lesson = {
        title: row['lesson'],
        author: row['author'],
      };
      let index = courses.findIndex((e) => e.title === row['course']);
      if (index >= 0) {
        if (lesson.title) courses[index]['curriculum'].push(lesson);
        return;
      }
      data['curriculum'] = [];
      data['curriculum'].push(lesson);
      for (let key in row) {
        if (key.startsWith('_')) continue;
        if (
          row[key] &&
          row[key] !== '' &&
          row[key] !== undefined &&
          row[key] !== 'undefined'
        ) {
          if (key !== 'lesson' && key !== 'author') {
            let columnCase = key === 'course' ? 'title' : key.toLowerCase();
            data[columnCase] = row[key];
          }
        }
      }

      courses.push(data);
    });

    console.log(
      '1>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.============================================='
    );
    courses.forEach(async (d) => {
      // await db.collection('_courses').add(d);
    });
    console.log(
      '2>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.==========================================='
    );

    res.send('Records have been successfully added to firestore');
  } catch (e) {
    console.log(e.toString());
    res.send(e.toString());
  }
});
