//+------------------------------------------------------------------+
//|                                               TestMarketBook.mq5 |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2015, MetaQuotes Software Corp."
#property link      "http://www.mql5.com"
#property version   "1.00"
#include <Trade\MarketBook.mqh>     // Include CMarketBook class
CMarketBook Book(Symbol());         // Initialize class with current instrument

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()
  {
   PrintMbookInfo();
   return INIT_SUCCEEDED;
  }
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnTimer()
  {
u//---
   
  }
//+------------------------------------------------------------------+
//| Print MarketBook Info                                            |
//+------------------------------------------------------------------+
void PrintMbookInfo()
  {
   Book.Refresh();                                                   // Update Depth of Market status.
   /* Get main integer-value statistics\ */
   int total=(int)Book.InfoGetInteger(MBOOK_DEPTH_TOTAL);            // Get total Depth of Market
   int total_ask = (int)Book.InfoGetInteger(MBOOK_DEPTH_ASK);        // Get the amount of Sell price levels
   int total_bid = (int)Book.InfoGetInteger(MBOOK_DEPTH_BID);        // Get the amount of Buy price levels
   int best_ask = (int)Book.InfoGetInteger(MBOOK_BEST_ASK_INDEX);    // Get index of best Ask price
   int best_bid = (int)Book.InfoGetInteger(MBOOK_BEST_BID_INDEX);    // Get index of best Bid price

   /* Displaу basic statistics */
   printf("TOTAL DEPTH OF MARKET: "+(string)total);
   printf("NUMBER OF PRICE LEVELS FOR SELL: "+(string)total_ask);
   printf("NUMBER OF PRICE LEVELS FOR BUY: "+(string)total_bid);
   printf("INDEX OF BEST BID: "+(string)best_ask);
   printf("INDEX OF BEST ASK PRICE: "+(string)best_bid);
   
   /* Get main statistics of double */
   double best_ask_price = Book.InfoGetDouble(MBOOK_BEST_ASK_PRICE); // Get best Ask price
   double best_bid_price = Book.InfoGetDouble(MBOOK_BEST_BID_PRICE); // Get best Bid price
   double last_ask = Book.InfoGetDouble(MBOOK_LAST_ASK_PRICE);       // Get worst Ask price
   double last_bid = Book.InfoGetDouble(MBOOK_LAST_BID_PRICE);       // Get worst Bid price
   double avrg_spread = Book.InfoGetDouble(MBOOK_AVERAGE_SPREAD);    // Get the average spread during Depth of Market operation
   
   /* Output prices and spread */
   printf("BEST BID PRICE: " + DoubleToString(best_ask_price, Digits()));
   printf("BEST ASK PRICE: " + DoubleToString(best_bid_price, Digits()));
   printf("WORST BID PRICE: " + DoubleToString(last_ask, Digits()));
   printf("WORST ASK PRICE: " + DoubleToString(last_bid, Digits()));
   printf("AVERAGE SPREAD: " + DoubleToString(avrg_spread, Digits()));
  }
//+------------------------------------------------------------------+