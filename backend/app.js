/**
 * @author Chiev Wan zwan@andrew.cmu.edu
 * 
 * Nodejs express server that serves the front end. 
 */

const express = require('express');
const app = express();
const { exec } = require('child_process');
const bodyParser = require('body-parser');
const path = require('path');


app.use(express.static(path.join(__dirname, 'public')));
app.use(bodyParser.json());

/**
 * API ENDPOINT FOR STORING A NEW MUSIC FILE TO IPFS. 
 * Parameters: 
 * 1. music_path (the music file path that you would want to make an NFT)
 * 2. nft_name 
 * 3. nft_description
 */
app.post('/store_nft', (req, res) => {
    var music_path = req.body.music_path; 
    var nft_name = req.body.nft_name; 
    var nft_description = req.body.nft_description; 

    var script_cmd = `./backend/scripts/store_nft.sh ${music_path} ${nft_name} ${nft_description}`;
    exec(script_cmd, (error, stdout, stderr) => {
        if (error) {
            console.error(`exec error: ${error}`);
            return res.status(500).send("Error executing the script.");
        }
        console.log(stdout);
        res.send(stdout);
    });
});

app.listen(3007, () => {
    console.log('Server started on port 3007');
});
