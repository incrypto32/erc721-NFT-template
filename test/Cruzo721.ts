import "@nomiclabs/hardhat-ethers";
import "@nomiclabs/hardhat-waffle";
import { ethers } from "hardhat";
import { assert, expect } from "chai";
import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import { Cruzo721 } from "../typechain/Cruzo721";

const tokenDetails = {
  name: "Cruzo",
  symbol: "CRZ",
};

const real = (inp: string) => inp + "0".repeat(9);

describe("Cruzo", () => {
  let admin: SignerWithAddress;

  let signers: SignerWithAddress[];

  let token: Cruzo721;

  before(async () => {
    signers = await ethers.getSigners();
    admin = signers[0];
  });

  beforeEach(async () => {
    let Token = await ethers.getContractFactory("Cruzo721");
    token = (await Token.deploy()) as Cruzo721;
  });

  it("Token Details", async () => {
    expect(await token.name()).equal(tokenDetails.name);
    expect(await token.symbol()).equal(tokenDetails.symbol);
  });

  it("Create Token", async () => {
    await token.createToken("https://google.com");
    expect(await token.balanceOf(admin.address)).equal(1);
    expect(await token.ownerOf(1)).equal(admin.address);
  });

  it("Token Transfer", async () => {
    await token.createToken("https://google.com");
    await token.transferFrom(admin.address, signers[1].address, 1);
    expect(await token.ownerOf(1)).not.equal(admin.address);
    expect(await token.ownerOf(1)).equal(signers[1].address);
  });
});
