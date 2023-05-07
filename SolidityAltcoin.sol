pragma solidity >=0.7.0 <0.9.0;

contract ubmcoin {
    // Maximum number of UBMCOIN available for sale
    uint public max_ubmcoin = 777777;

    //USD to UBMCOIN conversion rate
    uint public usd_to_ubmcoin = 1000;

    //Total number of UBMCOIN that have been bought by the investors
    uint public total_ubmcoin_bought = 0;

    // Mapping from the investor address to its equity in UBMCOIN and USD
    mapping(address => uint) equity_ubmcoins;
    mapping(address => uint) equity_usd;

    // Checking if an investor can buy UBMCOIN
    modifier can_buy_ubmcoin(uint usd_invested) {
        require(usd_invested * usd_to_ubmcoin + total_ubmcoin_bought <= max_ubmcoin);

    }

    //Getting the equity in UBMCOIN of an investor
    function equity_in_ubmcoin(address investor) external constant returns (uint) {
        return equity_ubmcoins[investor];
    }

    //Getting the quity in USD of an investor
    fuction equity_usd(address investor) external constant returns (uint){
        return equity_usd[investor];
    }

    //Buying UBMCOIN
    function buy_ubmcoins(address investor, uint usd_invested) external
    can_buy_ubmcoin(usd_invested) {
        uint ubmcoins_bought = usd_invested * usd_to_ubmcoin;
        equity_ubmcoins[investor] += ubmcoins_bought;
        equity_usd[investor] = equity_ubmcoins[investor] / 1000;
        total_ubmcoin_bought += ubmcoins_bought;
    }

    //Selling UBMCOINS
    function sell_ubmcoins(address investor, uint ubmcoins_sold) external {
        equity_ubmcoins[investor] -= ubmcoins_sold;
        equity_usd[investor] = equity_ubmcoins[investor] / 1000;
        total_ubmcoin_bought -= ubmcoins_sold;
    }
}
