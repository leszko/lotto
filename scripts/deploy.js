const main = async () => {
    const lottoContractFactory = await hre.ethers.getContractFactory("LottoPortal");
    const lottoContract = await lottoContractFactory.deploy();
    await waveContract.deployed();
    console.log("LottoPortal address: ", waveContract.address);
  };
  
  const runMain = async () => {
    try {
      await main();
      process.exit(0);
    } catch (error) {
      console.error(error);
      process.exit(1);
    }
  };
  
  runMain();