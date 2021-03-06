//+------------------------------------------------------------------+
//|                                                   MarketBook.mq5 |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2015, MetaQuotes Software Corp."
#property link      "http://www.mql5.com"
#property version   "1.00"
#property indicator_separate_window
#property indicator_buffers 1
#property indicator_plots 1
#property indicator_type1 DRAW_LINE
#property indicator_color2 clrBlue

#include <Trade\MarketBook.mqh>
#include <Trade\MarketBook.mqh>

double delta_buffer[];
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
   SetIndexBuffer(0,delta_buffer,INDICATOR_DATA);   
   MarketBook.SetMarketBookSymbol(Symbol());
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
   ArraySetAsSeries(delta_buffer, true);
   MarketBook.Refresh();
   double total_buy = (double)MarketBook.InfoGetInteger(MBOOK_BID_VOLUME_TOTAL);
   double total_sell = (double)MarketBook.InfoGetInteger(MBOOK_ASK_VOLUME_TOTAL);
   double total = total_buy+total_sell;
   double ratio_buy = total != 0 ? total_buy/total : 0.0;
   double ratio_sell = total != 0 ? total_sell/total : 0.0;
   ask_sum += ratio_sell;
   bid_sum += ratio_buy;
   count++;
   double ask_percent = ask_sum / count * 100.0;
   //double bid_percent = (bid_sum / count)*(-1.0) * 100.0;
   delta_buffer[0] = ask_percent-50.0;
//--- return value of prev_calculated for next call
   return(rates_total);
  }

//+------------------------------------------------------------------+
