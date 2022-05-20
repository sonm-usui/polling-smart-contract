const main = async () => {
  const [owner, randomPerson] = await hre.ethers.getSigners();
  const pollingContractFactory = await hre.ethers.getContractFactory("NewPolling");
  const pollContract = await pollingContractFactory.deploy();
  await pollContract.deployed();

  console.log("Contract deployed to:", pollContract.address);
  console.log("Contract deployed by:", owner.address);

  let waveCount;
  waveCount = await pollContract.getVotersList();

  let waveTxn1 = await pollContract.vote('sonam');
  await waveTxn1.wait();
  console.log('Thanks for you vote');

  // waveCount = await pollContract.getVotersList();
  //  let waveTxn2 = await pollContract.connect(rand  omPerson).vote('choeda');
  // await waveTxn2.wait();

let waveTxn8 = await pollContract.connect(randomPerson).addCandidate('sonam');
  await waveTxn8.wait();
  let waveTxn9 = await pollContract.connect(randomPerson).addCandidate('choeda');
  await waveTxn9.wait();
   let waveTxn10 = await pollContract.connect(randomPerson).addCandidate('usui');
  await waveTxn10.wait();

  let waveTxn3 = await pollContract.connect(randomPerson).vote('sonam');
  await waveTxn3.wait();
    console.log('Thanks for you vote');
    let waveTxn5 = await pollContract.connect(randomPerson).vote('choeda');
  await waveTxn5.wait();
    console.log('Thanks for you vote');
    let waveTxn4 = await pollContract.connect(randomPerson).vote('choeda');
  await waveTxn4.wait();
  let waveTxn11 = await pollContract.connect(randomPerson).vote('sonam');
  await waveTxn11.wait();
   let waveTxn7 = await pollContract.connect(randomPerson).vote('usui');
  await waveTxn7.wait();

  let selected =  await pollContract.getVotersList();
  console.log(selected);

  let proposal = await pollContract.winnerName();
  console.log(proposal);
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();
