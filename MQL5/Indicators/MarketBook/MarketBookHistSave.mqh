//+------------------------------------------------------------------+
//|                                           MarketBookHistSave.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2015, MetaQuotes Software Corp."
#property link      "http://www.mql5.com"
//+------------------------------------------------------------------+
//| MarketBook Save to File                                          |
//+------------------------------------------------------------------+
class CMarketBookRatio
{
private:
   datetime       m_time;           // Time
   double         m_value_bid;      // Bid Value
   double         m_value_ask;      // Ask Value
public:
   string         ToString(void);
   void           FromString(string line);
};