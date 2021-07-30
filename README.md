# Guide for Deploying Sovryn Node on Akash:


# Sovryn Node:

<b>A Sovryn Node is the part of the Sovryn dapp that monitors the continuous marginal trading on the platform. It's main functions are as follows:</b>

<b>Liquidation of expired positions:</b>
The Nodes are check if leveraged trading positions on the platform are above liquidation levels (the trade margin is in excess of the maintenance margin). The nodes automatically liquidate positions if they fail this check and the liquidation criteria is met. The node then contacts both the liquidator and the liquidated and reports the outcome. 

<b>Rollover of open positions:</b>
When the maximum loan duration has been exceeded, the position will need to be rolled over. The function "rollover" on the protocol contract extends the loan duration by the maximum term (currently 28 days for margin trades) and pays the interest to the lender. The callers reward is 0.1% of the position size and also receives 2x the gas cost (using the fast gas price as base for the calculation).

<b>Taking advantage of arbitrage opportunities on the AMM:</b>
Earning money through arbitrage in situations where the expected price from the AMM deviates more than 2% from the oracle price for an asset. The node buys the side which is off.

# What is Akash?
Akash is an open source Cloud platform that lets you quickly deploy a Docker container to the Cloud provider of your choice for less than the cost of AWS, right from the command-line.

# Steps to Run Sovryn Node on Akash:
1) <b>We need to deploy Sovryn Node locally on the system</b>
2) <b>Then we contanizre the Sovryn Node application using docker</b>
3) <b>Finally, we will deploy it on Akash</b> 

# To deploy Sovryn node locally we need to follow some simple steps:
   * <b>Pre-requistes:</b>
     1) <b>NodeJs > 12.1</b>
        * You can find how to install nodejs here: https://nodejs.org/en/download/ 
     2) <b>Nodemon</b>
     3) <b>Webpack</b>
     4) <b>Prepare Wallets with Funds:</b>
        * We need to create 3 Wallets 1 liquidator wallet, 1 rollover wallet and 1 arbitrage wallet.You can simply create three metamask wallets and assign there address and private keys accordingly for each role.
        * To create a wallet using metamask for sovryn tesnet:
          * Go visit metamask website:https://metamask.io/
          * The there click on "Download button" and add metamask extension according to your browser(Supported browsers are: Firefox, Chrome, Brave and Edge). 
          * Open the metamask extension and create an account for yourself
             * Follow my guide on creating wallet on metamask:<a href="https://github.com/TanishqDsharma/SovrynNode-on-Akash/blob/main/Metamask_wallet_setup_Guide.md">Wallet-Setup-Guide</a>
             * You can also follow sovryn guide to create wallet on metamask:
                * https://wiki.sovryn.app/en/getting-started/wallet-setup  
          * Now, navigate to Settings-> Networks and Click on the "Add Network" button and enter the below RSK Testnet Network settings:
            * <b>Network Name:</b> RSK Testnet
            * <b>New RPC URL:</b> https://public-node.testnet.rsk.co
            * <b>Chain ID:</b> 31
            * <b>Currency Symbol:</b> tRBTC
            * <b>Block Explorer URL:</b> https://explorer.testnet.rsk.co 
        * Since we will be doing everything on testnet 
          * <b>You can top-up your wallets with doc, WRBTC and RBTC from:</b> https://faucet.sovryn.app/ , 
          * <b>You can top-up your wallets with TRBTC from:</b> https://faucet.rsk.co/  
          * <b>Access the sovryn test net DAPP from:</b> https://test.sovryn.app/
 
      
   1) <b>The very first step is to clone the Sovryn Node github repo,run the below commands in your terminal.</b>
      
      <b>Sovryn Github Repo :</b> https://github.com/DistributedCollective/Sovryn-Node 
      ```
      git clone https://github.com/DistributedCollective/Sovryn-Node.git
      cd Sovryn-Node
      ```
   2) <b>Now we need to run the below commands to install dependencies:</b>
      ```
      npm install
      npm install -g nodemon mocha
      ```
   3) <b>To run the build client:</b>
      ```
      npm run build-client
      ```
   
   4) <b>Create empty directories "logs" and "db" in the project root, run the below commands to create empty directories in your project root:</b>
      ```
      mkdir logs
      mkdir db
      ```
   5) <b>Create directory "secrets" and within a file accounts.js with the credentials of the liquidator/rollover/arbitrage wallets
ks = encrypted keystore file in v3 standard.(alternatively, you can specify pKey instead of ks to just use the private key).</b>
    
<b>Note:I used private keys instead of keystore for the deployment of sovryn node,you can use keystore.</b>
```
     export default {
    "liquidator": [{
        adr: "<liquidator_Account_address>",
        pKey: "<liquidator_Account_private_key>"
    }], 
    "rollover": [{
        adr: "<rollover_Account_address>",
        pKey: "<rollover_Account_private_key>"
    }],
    "arbitrage": [{
        adr: "<arbitrage_Account_address>",
        pKey: "<arbitrage_Account_private_key>"
    }],
}
```
   6) <Note:This is an optional step:> 
      <b>To receive notifications on telegram about new transactions and errors create a telegram bot-token-id and write in in a file:</b>   /secrets/telegram.js
      * Write this in your telegram.js file if you want to receive notifications on telegram and make sure you do provide the telegram-bot-token id which you can get by creating a bot in your telegram account
     
      ```
      export default "[telegram-bot-token]";
      ```
      
      <b> OR </b>
      * Write this in your telegram.js file if you do not want to receive notifications on telegram 
     
      ```
      export default ""; 
      ```
  
  7) <b>Charge the Sovryn node wallets with all relevant tokens and enough Rbtc to cover tx cost, and you do that my visiting the below faucets:</b>
      * https://faucet.rsk.co/ 
      * https://faucet.sovryn.app/ 

 8) <b>To approve the Sovryn smart contract to spend Doc on behalf of the Sovryn node wallets as well as the swap network contract to spend tokens on behalf of the arbitrage wallet, execute the below command:</b>
    ```
    node -r esm util/approval.js
    ```
 
 9) <b>After this you can finally start your Sovryn node by executing the below command:</b>
    ```
    node -r esm start.js test
    ```
    <b><b><b>OR</b></b></b>
 
 * <b>If you dont want to build everything, from scratch clone this github repo:</b>
   ```
   git clone https://github.com/TanishqDsharma/SovrynNode-on-Akash
   cd SovrynNode-on-Akash
   ```
   The above commands screenshot when ran in terminal:
   ![alt text](https://github.com/TanishqDsharma/SovrynNode-on-Akash/blob/main/screenshots/g1.png)
   
   ![alt text](https://github.com/TanishqDsharma/SovrynNode-on-Akash/blob/main/screenshots/g2.png)

   
   <b>After moving into the cloned repository, navigate to secrets folder and in accounts.js file, set your private key and account address for liquidator, rollover and arbitrage:</b>
   
   ![alt text](https://github.com/TanishqDsharma/SovrynNode-on-Akash/blob/main/screenshots/2.png)
   
   After setting up your keys and account addresses in accounts.js file, just run the below command
   ```
   node -r esm util/approval.js test
   node -r esm start.js test
   ```
   The above commands screenshot when ran in terminal:

   ![alt text](https://github.com/TanishqDsharma/SovrynNode-on-Akash/blob/main/screenshots/g3.png)
   
   ![alt text](https://github.com/TanishqDsharma/SovrynNode-on-Akash/blob/main/screenshots/g5.png)

   
   Now , in web browser navigate to http://127.0.0.1:3000 you will have the sovryn node running locally.
 
#  Containerizing Your Application:

Now,To Run your Sovryn Node  on Akash, we need to first containerize it. To containerize your application follow the below steps:

<b>To containerize your application follow the below steps:</b>
* Inside your Application Directory <b>"Create a DockerFile"</b> 
```docker
FROM node:12

ENV WHICHNET=test


RUN apt-get update && apt-get -y install procps

WORKDIR /app

###

COPY package.json /app
COPY package-lock.json /app

RUN npm install --loglevel verbose 
RUN npm install -g mocha nodemon

### Add application files

COPY . /app


RUN npm run build-client


RUN apt-get install -y curl jq
RUN node -r esm util/approval.js

CMD ["sh", "-c", "bash /app/get_secret"]

EXPOSE 3000

CMD ["sh", "-c", "npm run start:${WHICHNET}"]

```

* <b>To build the image execute the below command:</b>

  ``` 
  docker build -t <docker-image-name-here> .   
  ```
  
  ![alt text](https://github.com/TanishqDsharma/SovrynNode-on-Akash/blob/main/screenshots/d1.png)
  
  The above command will create a docker image with the name you provide above
  
* <b>To test your image execute the below command:</b>
   
   ``` 
   docker run -p 3000:3000 <docker-image-name> 
   ```
   
   ![alt text](https://github.com/TanishqDsharma/SovrynNode-on-Akash/blob/main/screenshots/d2.png)

  
## PUSH IMAGE TO DOCKERHUB:

After creating the docker image we need to make it publicly available so that it can be used with Akash Cloud.So, to push the docker image follow the below steps:

* The above command would have created a container id, to view the container id issue the command: <b><b>docker ps -a</b></b> and check the <b>container id</b> corresponding to the image name <b><your-docker-image-name></b> and copy it as you will be needing it in the next step.
  ```
  docker ps -a
  ```
  
  ![alt text](https://github.com/TanishqDsharma/SovrynNode-on-Akash/blob/main/screenshots/d3.png)

  
 
* Now Use the below commands to create a new image from exisiting container and push it to the docker hub

  ```
  docker commit container-id <docker-hub-username>/<docker-image-name>
  docker push <docker-hub-username>/<docker-image-name>
  ```
  
  ![alt text](https://github.com/TanishqDsharma/SovrynNode-on-Akash/blob/main/screenshots/d4%2Cpng.png)


<b>Finally, we are finished with pushing our docker image to dockerhub, now this image is publicly available and can be used by Akash for deployment purposes.</b>
  
# Deploying Your Application on Akash-Cloud:

After containerizing your application, deploying to Akash simply involves writing small configuration file and executing a couple of commands.Follow the below steps to successfully deploy your application on Akash:

## Create an Account:
  * You can give any name to your wallet in this case I used "TanishqWallet" 
    
    <b>In your terminal type:</b>
    ```
    akash keys add TanishqWallet
    ```
    * Read the output and save mnemonic phrase in a safe place.
  
  * In terminal also set your <b>AKASH_KEY_NAME=TanishqWallet</b>, in your case name could be different.
    
    In terminal execute the below command
    ```
    AKASH_KEY_NAME=TanishqWallet 
    
    ```


## Setup your Account Address in the terminal so that we can easily use it later:
  * Run the below commands in your terminal:
    * <b>export AKASH_ACCOUNT_ADDRESS="$(akash keys show TanishqWallet -a)"</b>
    * <b>echo $AKASH_ACCOUNT_ADDRESS</b>

## Fund Your Akash Account:
  * You can buy some AKT tokens from the exchanges like AscendEX, Osmosis, Bitmart. Find the full list of exchanges <a href="https://akash.network/token">here.</a> 

## Connect to the Network:
  * <b>Run the below commands one-by-one in your terminal to connect yourself to the network:</b>
    * AKASH_NET="https://raw.githubusercontent.com/ovrclk/net/master/mainnet"
    * AKASH_VERSION="$(curl -s "$AKASH_NET/version.txt")"
    * export AKASH_CHAIN_ID="$(curl -s "$AKASH_NET/chain-id.txt")"
    * export AKASH_NODE="$(curl -s "$AKASH_NET/rpc-nodes.txt" | head -1)"
    * echo $AKASH_NODE $AKASH_CHAIN_ID $AKASH_KEYRING_BACKEND
    * AKASH_KEYRING_BACKEND=os

  ## Check your Account Balance:
  * Run the below command in your terminal to check the account balance:
  
    ``` 
    akash query bank balances --node $AKASH_NODE $AKASH_ACCOUNT_ADDRESS 
    ```

## Create your Configuration:
  * <b>Create a deployment configuration named as deploy.yml in the root directory.</b>
```
---
version: "2.0"

services:
  web:
    image: <your-docker-hub-username>/<docker-image-name>
    env:
      - WHICHNET=test
      - LIQUIDATOR_ADDRESS="<your-liquidator-account-address>"
      - LIQUIDATOR_PRIVATE_KEY="<your-liquidator-account-pvt-key>"
      - ROLLOVER_ADDRESS="<your-liquidator-rollover-address>"
      - ROLLOVER_PRIVATE_KEY= "<your-rollover-account-pvt-key>"
      - ARBITRAGE_ADDRESS="<your-arbitrage-account-address>"
      - ARBITRAGE_PRIVATE_KEY="<your-arbitrage-account-pvt-key>"
         
    expose:
      - port: 3000
        as: 80
        to:
          - global: true

profiles:
  compute:
    web:
      resources:
        cpu:
          units: 0.1
        memory:
          size: 512Mi
        storage:
          size: 512Mi
  placement:
    westcoast:
      attributes:
        host: akash
      signedBy:
        anyOf:
          - "akash1365yvmc4s7awdyj3n2sav7xfx76adc6dnmlx63"
      pricing:
        web: 
          denom: uakt
          amount: 1000

deployment:
  web:
    westcoast:
      profile: web
      count: 1

```

* Note: Make sure to change the image according to your docker image in deploy.yml file.
  * image: USERNAME/DOCKERIMAGE
  * In my case it was: tanishq512/sovryn:latest


## Create a certificate: 
  * Before you can create a deployment, a certificate must first be created. Your certificate needs to be created only once per account and can be used across all deployments.To     create the certificate run the below command in your terminal:
    
  ``` 
  akash tx cert create client --chain-id $AKASH_CHAIN_ID --keyring-backend $AKASH_KEYRING_BACKEND --from $AKASH_KEY_NAME --node $AKASH_NODE --fees 5000uakt
  ```
  
<b>Above command will generate an ouput like this:</b>
```
{

no certificate found for address akash129eaqvm3ujs606e47naef776s5yc0y8vnu4w2w. generating new...

{"body":
{"messages":
[{"@type":"/akash.cert.v1beta1.MsgCreateCertificate",
"owner":"akash129eaqvm3ujs606e47naef776s5yc0y8vnu4w2w",
"cert":"LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUJ2ekNDQVdXZ0F3SUJBZ0lJRm84a3VKc200YWd3Q2dZSUtvWkl6ajBFQXdJd1NqRTFNRE1HQTFVRUF4TXMKWVd0aGMyZ3hNamxsWVhGMmJUTjFhbk0yTURabE5EZHVZV1ZtTnpjMmN6VjVZekI1T0hadWRUUjNNbmN4RVRBUApCZ1ZuZ1FVQ0JoTUdkakF1TUM0eE1CNFhEVEl4TURjd05qQTNOVGt5TlZvWERUSXlNRGN3TmpBM05Ua3lOVm93ClNqRTFNRE1HQTFVRUF4TXNZV3RoYzJneE1qbGxZWEYyYlROMWFuTTJNRFpsTkRkdVlXVm1OemMyY3pWNVl6QjUKT0hadWRUUjNNbmN4RVRBUEJnVm5nUVVDQmhNR2RqQXVNQzR4TUZrd0V3WUhLb1pJemowQ0FRWUlLb1pJemowRApBUWNEUWdBRWlaZkdqVWNhTDl5YmtYc1pmY256YVNvNWZycm5qV2V1NzVtTlY2OFV1SE5reGlCZStWNTJTZXVrCkM0NG1oRmRBRkdxUlBwbzNqZDBKZHp5cE5tU3N2cU0xTURNd0RnWURWUjBQQVFIL0JBUURBZ1F3TUJNR0ExVWQKSlFRTU1Bb0dDQ3NHQVFVRkJ3TUNNQXdHQTFVZEV3RUIvd1FDTUFBd0NnWUlLb1pJemowRUF3SURTQUF3UlFJZwpNYTFQMEV4ZnpzcmtGWTZUOUNSMlAyakVZR1dRTFdRZHFpQnN6OGM0cUZvQ0lRRFlEUVlIYmlGanh5WUIyRnFiCldZMTFqRlNSUHpwUXRMMmd3eXNsYUZCS1NnPT0KLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo=",
"pubkey":"LS0tLS1CRUdJTiBFQyBQVUJMSUMgS0VZLS0tLS0KTUZrd0V3WUhLb1pJemowQ0FRWUlLb1pJemowREFRY0RRZ0FFaVpmR2pVY2FMOXlia1hzWmZjbnphU281ZnJybgpqV2V1NzVtTlY2OFV1SE5reGlCZStWNTJTZXVrQzQ0bWhGZEFGR3FSUHBvM2pkMEpkenlwTm1Tc3ZnPT0KLS0tLS1FTkQgRUMgUFVCTElDIEtFWS0tLS0tCg=="}],
"memo":"",
"timeout_height":"0",
"extension_options":[],
"non_critical_extension_options":[]},
"auth_info":{
"signer_infos":[],
"fee":{
"amount":[{"denom":"uakt","amount":"5000"}],
"gas_limit":"200000",
"payer":"",
"granter":""
}
},
"signatures":[]}

confirm transaction before signing and broadcasting [y/N]: y
{"height":"1674650",
"txhash":"CE9C2889E2F04D80E05402927EF01F7C2CBE55FDEDA4C4E71F7E63943A01D122",
"codespace":"","code":0,"data":"0A190A17636572742D6372656174652D6365727469666963617465",
"raw_log":"[{\"events\":[{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"cert-create-certificate\"},{\"key\":\"sender\",\"value\":\"akash129eaqvm3ujs606e47naef776s5yc0y8vnu4w2w\"}]},{\"type\":\"transfer\",\"attributes\":[{\"key\":\"recipient\",\"value\":\"akash17xpfvakm2amg962yls6f84z3kell8c5lazw8j8\"},{\"key\":\"sender\",\"value\":\"akash129eaqvm3ujs606e47naef776s5yc0y8vnu4w2w\"},{\"key\":\"amount\",\"value\":\"5000uakt\"}]}]}]","logs":[{"msg_index":0,"log":"","events":[{"type":"message","attributes":[{"key":"action","value":"cert-create-certificate"},{"key":"sender","value":"akash129eaqvm3ujs606e47naef776s5yc0y8vnu4w2w"}]},{"type":"transfer","attributes":[{"key":"recipient","value":"akash17xpfvakm2amg962yls6f84z3kell8c5lazw8j8"},{"key":"sender","value":"akash129eaqvm3ujs606e47naef776s5yc0y8vnu4w2w"},{"key":"amount","value":"5000uakt"}]}]}],"info":"","gas_wanted":"200000","gas_used":"93013","tx":null,"timestamp":""}


 }
 ```


## Create a Deployment:
  * <b>To create a deployment on akash run:</b>
    ```
    akash tx deployment create deploy.yml --from $AKASH_KEY_NAME --node $AKASH_NODE --chain-id $AKASH_CHAIN_ID --fees 5000uakt -y
    ```
  
<b>Above command will generate an output like this:</b>
 
 ```
 
{
"height":"1793620",
"txhash":"5A38A596D88718828A48F2EBE9121C67BFDDF4EA1717A350F51A8CC56FBF87C3",
"codespace":"",
"code":0,
"data":"0A130A116372656174652D6465706C6F796D656E74",
"raw_log":"[{\"events\":[{\"type\":\"akash.v1\",\"attributes\":[{\"key\":\"module\",\"value\":\"deployment\"},{\"key\":\"action\",\"value\":\"deployment-created\"},{\"key\":\"version\",\"value\":\"b31cd1d10b75330fb82fb91e6d0495b2bd41d9d9bdd8d32a4532e6e61525749a\"},{\"key\":\"owner\",\"value\":\"akash129eaqvm3ujs606e47naef776s5yc0y8vnu4w2w\"},{\"key\":\"dseq\",\"value\":\"1793619\"},{\"key\":\"module\",\"value\":\"market\"},{\"key\":\"action\",\"value\":\"order-created\"},{\"key\":\"owner\",\"value\":\"akash129eaqvm3ujs606e47naef776s5yc0y8vnu4w2w\"},{\"key\":\"dseq\",\"value\":\"1793619\"},{\"key\":\"gseq\",\"value\":\"1\"},{\"key\":\"oseq\",\"value\":\"1\"}]},{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"create-deployment\"},{\"key\":\"sender\",\"value\":\"akash129eaqvm3ujs606e47naef776s5yc0y8vnu4w2w\"},{\"key\":\"sender\",\"value\":\"akash129eaqvm3ujs606e47naef776s5yc0y8vnu4w2w\"}]},{\"type\":\"transfer\",\"attributes\":[{\"key\":\"recipient\",\"value\":\"akash17xpfvakm2amg962yls6f84z3kell8c5lazw8j8\"},{\"key\":\"sender\",\"value\":\"akash129eaqvm3ujs606e47naef776s5yc0y8vnu4w2w\"},{\"key\":\"amount\",\"value\":\"5000uakt\"},{\"key\":\"recipient\",\"value\":\"akash14pphss726thpwws3yc458hggufynm9x77l4l2u\"},{\"key\":\"sender\",\"value\":\"akash129eaqvm3ujs606e47naef776s5yc0y8vnu4w2w\"},{\"key\":\"amount\",\"value\":\"5000000uakt\"}]}]}]",
"logs":[
{
"msg_index":0,
"log":"",
"events":[
{"type":"akash.v1",
"attributes":[
{"key":"module","value":"deployment"},
{"key":"action","value":"deployment-created"},{"key":"version","value":"b31cd1d10b75330fb82fb91e6d0495b2bd41d9d9bdd8d32a4532e6e61525749a"},{"key":"owner","value":"akash129eaqvm3ujs606e47naef776s5yc0y8vnu4w2w"},{"key":"dseq","value":"1793619"},{"key":"module","value":"market"},
{"key":"action","value":"order-created"},
{"key":"owner","value":"akash129eaqvm3ujs606e47naef776s5yc0y8vnu4w2w"},
{"key":"dseq","value":"1793619"},
{"key":"gseq","value":"1"},
{"key":"oseq","value":"1"}]},
{"type":"message","attributes":[{"key":"action","value":"create-deployment"},{"key":"sender","value":"akash129eaqvm3ujs606e47naef776s5yc0y8vnu4w2w"},{"key":"sender","value":"akash129eaqvm3ujs606e47naef776s5yc0y8vnu4w2w"}]},{"type":"transfer","attributes":[{"key":"recipient","value":"akash17xpfvakm2amg962yls6f84z3kell8c5lazw8j8"},{"key":"sender","value":"akash129eaqvm3ujs606e47naef776s5yc0y8vnu4w2w"},{"key":"amount","value":"5000uakt"},{"key":"recipient","value":"akash14pphss726thpwws3yc458hggufynm9x77l4l2u"},{"key":"sender","value":"akash129eaqvm3ujs606e47naef776s5yc0y8vnu4w2w"},{"key":"amount","value":"5000000uakt"}]}]}],"info":"","gas_wanted":"200000","gas_used":"94668","tx":null,"timestamp":""}

 
 ```

## Find your Deployment Sequence:
  * From the above output we need the values of DSEQ,GSEQ and OSEQ.After extracting the values from above output set the me to shell variables
    * AKASH_DSEQ = 1793619 
    * AKASH_GSEQ = 1
    * AKASH_OSEQ = 1

## Verify deployment is open:
   * <b>To verify deployment is open run the below command</b>
   ```
   akash query deployment get --owner $AKASH_ACCOUNT_ADDRESS --node $AKASH_NODE --dseq $AKASH_DSEQ
   ```
## Verify Order is Open: 
  * <b>To verify the order run the below command in your terminal:</b>
        
    
    ```
    akash query market order get --node $AKASH_NODE --owner $AKASH_ACCOUNT_ADDRESS --dseq $AKASH_DSEQ --oseq $AKASH_OSEQ --gseq $AKASH_GSEQ
    ```
## View your Bids:
  * <b>After a short time, you should see bids from providers for this deployment with the following command:</b>  
  
    ```   
    akash query market bid list --owner=$AKASH_ACCOUNT_ADDRESS --node $AKASH_NODE --dseq $AKASH_DSEQ
    ```

 <b> The above command will generate an output like this:</b>
  
 ```
 bid:
bids:
- bid:
    bid_id:
      dseq: "1793619"
      gseq: 1
      oseq: 1
      owner: akash129eaqvm3ujs606e47naef776s5yc0y8vnu4w2w
      provider: akash10cl5rm0cqnpj45knzakpa4cnvn5amzwp4lhcal
    created_at: "1793621"
    price:
      amount: "1"
      denom: uakt
    state: open
  escrow_account:
    balance:
      amount: "50000000"
      denom: uakt
    id:
      scope: bid
      xid: akash129eaqvm3ujs606e47naef776s5yc0y8vnu4w2w/1793619/1/1/akash10cl5rm0cqnpj45knzakpa4cnvn5amzwp4lhcal
    owner: akash10cl5rm0cqnpj45knzakpa4cnvn5amzwp4lhcal
    settled_at: "1793621"
    state: open
    transferred:
      amount: "0"
      denom: uakt
- bid:
    bid_id:
      dseq: "1793619"
      gseq: 1
      oseq: 1
      owner: akash129eaqvm3ujs606e47naef776s5yc0y8vnu4w2w
      provider: akash1f6gmtjpx4r8qda9nxjwq26fp5mcjyqmaq5m6j7
    created_at: "1793621"
    price:
      amount: "2"
      denom: uakt
    state: open
  escrow_account:
    balance:
      amount: "50000000"
      denom: uakt
    id:
      scope: bid
      xid: akash129eaqvm3ujs606e47naef776s5yc0y8vnu4w2w/1793619/1/1/akash1f6gmtjpx4r8qda9nxjwq26fp5mcjyqmaq5m6j7
    owner: akash1f6gmtjpx4r8qda9nxjwq26fp5mcjyqmaq5m6j7
    settled_at: "1793621"
    state: open
    transferred:
      amount: "0"
      denom: uakt
pagination:
  next_key: null
  total: "0"
 ```
## Choose a provider from the above the output:
   * Note that there are bids from multiple different providers. In this case, both providers happen to be willing to accept a price of 1 uAKT. This means that the lease can be created using 1 uAKT or 0.000001 AKT per block to execute the container.
   * For this example, we will choose akash10cl5rm0cqnpj45knzakpa4cnvn5amzwp4lhca
   * In your terminal run: 
     
      ```
      AKASH_PROVIDER=akash10cl5rm0cqnpj45knzakpa4cnvn5amzwp4lhcal
     ```
   * To verify the AKASH_PROVIDER, run the below  command:
     ```
     echo $AKASH_PROVIDER
     ```

## Create a lease:
      ```
      akash tx market lease create --chain-id $AKASH_CHAIN_ID --node $AKASH_NODE --owner $AKASH_ACCOUNT_ADDRESS --dseq $AKASH_DSEQ --gseq $AKASH_GSEQ --oseq $AKASH_OSEQ --   provider $AKASH_PROVIDER --from $AKASH_KEY_NAME --fees 5000uakt
      ```
 
 <b>The above command will generate an output like below</b>
  
 ```
 {"body":{"messages":[{"@type":"/akash.market.v1beta1.MsgCreateLease","bid_id":{"owner":"akash129eaqvm3ujs606e47naef776s5yc0y8vnu4w2w","dseq":"1793619","gseq":1,"oseq":1,"provider":"akash10cl5rm0cqnpj45knzakpa4cnvn5amzwp4lhcal"}}],"memo":"","timeout_height":"0","extension_options":[],"non_critical_extension_options":[]},"auth_info":{"signer_infos":[],"fee":{"amount":[{"denom":"uakt","amount":"5000"}],"gas_limit":"200000","payer":"","granter":""}},"signatures":[]}

confirm transaction before signing and broadcasting [y/N]: y
{
"height":"1793633",
"txhash":"6E94F3869BC4747C5E848D6E85FFD633EB2DBE7FD8008F64B8D02B32DEF9B5C9",
"codespace":"",
"code":0,
"data":"0A0E0A0C6372656174652D6C65617365",
"raw_log":"[{\"events\":[{\"type\":\"akash.v1\",\"attributes\":[{\"key\":\"module\",\"value\":\"market\"},{\"key\":\"action\",\"value\":\"lease-created\"},{\"key\":\"owner\",\"value\":\"akash129eaqvm3ujs606e47naef776s5yc0y8vnu4w2w\"},{\"key\":\"dseq\",\"value\":\"1793619\"},{\"key\":\"gseq\",\"value\":\"1\"},{\"key\":\"oseq\",\"value\":\"1\"},{\"key\":\"provider\",\"value\":\"akash10cl5rm0cqnpj45knzakpa4cnvn5amzwp4lhcal\"},{\"key\":\"price-denom\",\"value\":\"uakt\"},{\"key\":\"price-amount\",\"value\":\"1\"}]},{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"create-lease\"},{\"key\":\"sender\",\"value\":\"akash129eaqvm3ujs606e47naef776s5yc0y8vnu4w2w\"},{\"key\":\"sender\",\"value\":\"akash14pphss726thpwws3yc458hggufynm9x77l4l2u\"}]},{\"type\":\"transfer\",\"attributes\":[{\"key\":\"recipient\",\"value\":\"akash17xpfvakm2amg962yls6f84z3kell8c5lazw8j8\"},{\"key\":\"sender\",\"value\":\"akash129eaqvm3ujs606e47naef776s5yc0y8vnu4w2w\"},{\"key\":\"amount\",\"value\":\"5000uakt\"},{\"key\":\"recipient\",\"value\":\"akash1f6gmtjpx4r8qda9nxjwq26fp5mcjyqmaq5m6j7\"},{\"key\":\"sender\",\"value\":\"akash14pphss726thpwws3yc458hggufynm9x77l4l2u\"},{\"key\":\"amount\",\"value\":\"50000000uakt\"}]}]}]",
"logs":[{"msg_index":0,"log":"","events":[{"type":"akash.v1","attributes":[{"key":"module","value":"market"},{"key":"action","value":"lease-created"},{"key":"owner","value":"akash129eaqvm3ujs606e47naef776s5yc0y8vnu4w2w"},{"key":"dseq","value":"1793619"},{"key":"gseq","value":"1"},{"key":"oseq","value":"1"},{"key":"provider","value":"akash10cl5rm0cqnpj45knzakpa4cnvn5amzwp4lhcal"},{"key":"price-denom","value":"uakt"},{"key":"price-amount","value":"1"}]},{"type":"message","attributes":[{"key":"action","value":"create-lease"},{"key":"sender","value":"akash129eaqvm3ujs606e47naef776s5yc0y8vnu4w2w"},{"key":"sender","value":"akash14pphss726thpwws3yc458hggufynm9x77l4l2u"}]},{"type":"transfer","attributes":[{"key":"recipient","value":"akash17xpfvakm2amg962yls6f84z3kell8c5lazw8j8"},{"key":"sender","value":"akash129eaqvm3ujs606e47naef776s5yc0y8vnu4w2w"},{"key":"amount","value":"5000uakt"},{"key":"recipient","value":"akash1f6gmtjpx4r8qda9nxjwq26fp5mcjyqmaq5m6j7"},{"key":"sender","value":"akash14pphss726thpwws3yc458hggufynm9x77l4l2u"},{"key":"amount","value":"50000000uakt"}]}]}],"info":"","gas_wanted":"200000","gas_used":"131348","tx":null,"timestamp":""}
                                       
 ```
 
 ### Confirm the lease:
      ```
      akash query market lease list --owner $AKASH_ACCOUNT_ADDRESS --node $AKASH_NODE --dseq $AKASH_DSEQ
      ```
<b> The above command will generate an ouput like below:</b>
```
leases:
- escrow_payment:
    account_id:
      scope: deployment
      xid: akash129eaqvm3ujs606e47naef776s5yc0y8vnu4w2w/1793619
    balance:
      amount: "0"
      denom: uakt
    owner: akash10cl5rm0cqnpj45knzakpa4cnvn5amzwp4lhcal
    payment_id: 1/1/akash10cl5rm0cqnpj45knzakpa4cnvn5amzwp4lhcal
    rate:
      amount: "1"
      denom: uakt
    state: open
    withdrawn:
      amount: "0"
      denom: uakt
  lease:
    created_at: "1793633"
    lease_id:
      dseq: "1793619"
      gseq: 1
      oseq: 1
      owner: akash129eaqvm3ujs606e47naef776s5yc0y8vnu4w2w
      provider: akash10cl5rm0cqnpj45knzakpa4cnvn5amzwp4lhcal
    price:
      amount: "1"
      denom: uakt
    state: active
pagination:
  next_key: null
  total: "0"

```
### Send the Manifest:
     ``` 
     akash provider send-manifest deploy.yml --node $AKASH_NODE --dseq $AKASH_DSEQ --provider $AKASH_PROVIDER --home ~/.akash --from $AKASH_KEY_NAME
     ```
<b>Note: The above command will not generate any output.</b>
  
## Confirm the URL:
  * Now that the manifest is uploaded, your image is deployed. You can retrieve the access details by running the below:
  
   ```
   akash provider lease-status --node $AKASH_NODE --home ~/.akash --dseq $AKASH_DSEQ --from $AKASH_KEY_NAME --provider $AKASH_PROVIDER
   ```

<b>The above command will generate an output like below:</b> 

```
{
  "services": {
    "web": {
      "name": "web",
      "available": 0,
      "total": 1,
      "uris": [
        "io375ka6dldvb3drt7do4s1q78.ingress.sjc1p0.mainnet.akashian.io"
      ],
      "observed_generation": 1,
      "replicas": 1,
      "updated_replicas": 1,
      "ready_replicas": 0,
      "available_replicas": 0
    }
  },
  "forwarded_ports": {}
}
```

* <b>Since we got the URL from the above result, we can access the Sovryn Node at:</b>
  
  ```
  http://io375ka6dldvb3drt7do4s1q78.ingress.sjc1p0.mainnet.akashian.io/
  ```



# Conclusion:
  * I have successfully deployed Sovryn Node on akash just by following the above steps
  * <b>My Sovryn Node link: </b>http://io375ka6dldvb3drt7do4s1q78.ingress.sjc1p0.mainnet.akashian.io/
  * For futher guidance to deploy your application on Akash you can follow Akash docs for beginners: https://docs.akash.network/guides/deployment

