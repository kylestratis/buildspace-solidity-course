const hre = require("hardhat");
const ethers = hre.ethers;

const WavePortal = ethers.getContractFactory("WavePortal");
const waveportal = WavePortal.deploy();
