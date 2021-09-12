async function main() {
    // TODO: Move stats to blockchain?
    let timeStats = new Map();
    let waverStats = new Map();
    const [owner, randoPerson] = await hre.ethers.getSigners();
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
    const waveContract = await waveContractFactory.deploy();
    await waveContract.deployed();
    console.log("Contract deployed to: ", waveContract.address);
    console.log("Contract deployed by: ", owner.address);

    let waveCount;
    waveCount = await waveContract.getTotalWaves();
    
    let waveTxn = await waveContract.wave();
    await waveTxn.wait();
    waverStats.has(owner.address) ? waverStats.set(owner.address, waverStats.get(owner.address) + 1) : waverStats.set(owner.address, 1);

    waveCount = await waveContract.getTotalWaves();

    for (let i = 0; i <= 3; i++) {
        waveTxn = await waveContract.connect(randoPerson).wave();
        await waveTxn.wait();
        waverStats.has(randoPerson.address) ? waverStats.set(randoPerson.address, waverStats.get(randoPerson.address) + 1) : waverStats.set(randoPerson.address, 1);
    }

    waveCount = await waveContract.getTotalWaves();
    console.log(waverStats);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
