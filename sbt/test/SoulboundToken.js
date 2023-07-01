const {
	time,
	loadFixture,
} = require("@nomicfoundation/hardhat-network-helpers");
const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
const { expect } = require("chai");

describe("SoulboundToken", function () {
	// We define a fixture to reuse the same setup in every test.
	// We use loadFixture to run this setup once, snapshot that state,
	// and reset Hardhat Network to that snapshot in every test.
	async function deploySoulboundTokenFixture() {
		// Contracts are deployed using the first signer/account by default
		const [owner, otherAccount] = await ethers.getSigners();

		const SoulboundToken = await ethers.getContractFactory(
			"SoulboundToken"
		);
		const soulboundToken = await SoulboundToken.deploy();

		return { soulboundToken, owner, otherAccount };
	}

	describe("Deployment", function () {
		it("Should set the name", async function () {
			const { soulboundToken } = await loadFixture(
				deploySoulboundTokenFixture
			);

			expect(await soulboundToken.name()).to.equal("Fantom SBT");
		});

		it("Should set the symbol", async function () {
			const { soulboundToken } = await loadFixture(
				deploySoulboundTokenFixture
			);

			expect(await soulboundToken.symbol()).to.equal("FSBT");
		});
	});
});
