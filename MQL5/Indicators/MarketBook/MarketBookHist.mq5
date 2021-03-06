//+------------------------------------------------------------------+
//|                                                   MarketBook.mq5 |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2015, MetaQuotes Software Corp."
#property link      "http://www.mql5.com"
#property version   "1.00"
#property indicator_separate_window
#property indicator_buffers 2
#property indicator_plots 2
#property indicator_type1 DRAW_HISTOGRAM
#property indicator_type2 DRAW_HISTOGRAM
#property indicator_level1 50.0
#property indicator_level2 0.00
#property indicator_level3 -50.0
#property indicator_color1 clrRed
#property indicator_color2 clrBlue

#include <Trade\MarketBook.mqh>
#include <Trade\MarketBook.mqh>

double ask_buffer[];
double bid_buffer[];
double ask_sum = 0.0;
double bid_sum = 0.0;
int    count = 0;
CMarketBook MarketBook;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
   SetIndexBuffer(0,ask_buffer,INDICATOR_DATA);
   SetIndexBuffer(1,bid_buffer,INDICATOR_DATA);
   MarketBookAdd(Symbol());
u//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| MarketBook change event                                          |
//+------------------------------------------------------------------+
void OnBookEvent(const string &symbol)
  {
   MarketBook.Refresh();
   ChartRedraw();
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const int begin,
                const double &price[])
  {
u//---
   if(prev_calculated != rates_total)
   {
      ask_sum = bid_sum = 0.0;
      count = 0;
   }
   if(prev_calculated == 0)
      return rates_total;
   ArraySetAsSeries(ask_buffer, true);
   ArraySetAsSeries(bid_buffer, true);
   MarketBook.Refresh();
   double total_buy = (double)MarketBook.InfoGetInteger(MBOOK_BID_VOLUME_TOTAL);
   double total_sell = (double)MarketBook.InfoGetInteger(MBOOK_ASK_VOLUME_TOTAL);
   double total = total_buy+total_sell;
   double ratio_buy = total != 0 ? total_buy/total : 0.0;
   double ratio_sell = total != 0 ? total_sell/total : 0.0;
   ask_sum += ratio_sell;
   bid_sum += ratio_buy;
   count++;
   ask_buffer[0] = ask_sum / count * 100.0;
   bid_buffer[0] = (bid_sum / count)*(-1.0) * 100.0;
//--- return value of prev_calculated for next call
   return(rates_total);
  }

//+------------------------------------------------------------------+
