#!/usr/bin/env node

const fetchSecretKey = require('juice-shop-ctf-cli/lib/fetchSecretKey')
const fetchChallenges = require('juice-shop-ctf-cli/lib/fetchChallenges')
const generateData = require('juice-shop-ctf-cli/lib/generateData')
const options = require('juice-shop-ctf-cli/lib/options')

const fs = require('fs')
const util = require('util')

const Zip = require('node-zip')
const zip = new Zip()

function writeToZipFile ({challenges, hints, flagKeys}) {
  return new Promise((resolve, reject) => {
    const fileName = 'juice-shop-challenges.zip'
    zip.file('db/challenges.json', JSON.stringify(challenges))
    zip.file('db/hints.json', JSON.stringify(hints))
    zip.file('db/keys.json', JSON.stringify(flagKeys))
    zip.file('db/files.json', '')
    zip.file('db/tags.json', '')
    return util.promisify(fs.writeFile)(fileName, zip.generate({base64: false, compression: 'DEFLATE'}), 'binary')
  })
}

const generateChallenges = async () => {
  try {
    const ctfKey = 'https://raw.githubusercontent.com/bkimminich/juice-shop/master/ctf.key',
          juiceShopUrl = 'http://juice-shop:3000',
          insertHints = 1,
          insertHintUrls = 0;
    const [secretKey, challenges] = await Promise.all([
      fetchSecretKey(ctfKey),
      fetchChallenges(juiceShopUrl)
    ])
    const data = await generateData(challenges, insertHints, insertHintUrls, secretKey)
    const file = await writeToZipFile(data)
  } catch (error) {
    console.log(error.message)
  }
}

generateChallenges()
