//+------------------------------------------------------------------+
//|                                                   MBookPanel.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2015, MetaQuotes Software Corp."
#property link      "http://www.mql5.com"
#include <Trade\MarketBook.mqh>
#include <Panel\ElChart.mqh>
#include "MBookCeil.mqh"
#include "MBookFon.mqh"
//+------------------------------------------------------------------+
//| Adds to the Depth of Market the histogram of total buy/sell      |
//+------------------------------------------------------------------+
class CBookFonRatio : public CBookFon
{
private:
   CElChart       m_buy_hist;       // The histogram of total buy 
   CElChart       m_buy_hist;       // The histogram of total sell  
   CElChart       m_buy_per;        // Percent of total buy
   CElChart       m_sell_per;       // Percent of total sell
   void           OnShowBuyHist(void);
   void           OnShowSellHist(void);
   int            GetHistPipsTotal(void);
public:
                  CBookFonRatio(CMarketBook* book);
   virtual void   OnRefresh(CEventRefresh* refresh);
   virtual void   OnShow(void);
};
void CBookFonRatio::CBookFonRatio(CMarketBook* book) : CBookFon(book),
                                          m_buy_hist(OBJ_RECTANGLE_LABEL),
                                          m_sell_hist(OBJ_RECTANGLE_LABEL),
                                          m_buy_per(OBJ_LABEL),
                                          m_sell_per(OBJ_LABEL)
{
}
//+------------------------------------------------------------------+
//| Displays extended Depth of Market                                |
//+------------------------------------------------------------------+
void CBookFonRatio::OnShow(void)
{
   CBookFon::OnShow();
   long x = XCoord() + Width() - 40;
   m_buy_hist.XCoord(x);
   m_buy_hist.BorderColor(clrBlack);
   m_buy_hist.BackgroundColor(clrCornflowerBlue);
   m_buy_hist.Width(30);
   m_buy_hist.Show();
   m_elements.Add(GetPointer(m_buy_hist));
   
   m_sell_hist.XCoord(x);
   m_sell_hist.Width(30);
   m_sell_hist.BorderColor(clrBlack);
   m_sell_hist.BackgroundColor(clrPink);
   m_sell_hist.Show();
   m_elements.Add(GetPointer(m_sell_hist));
   
   m_buy_per.XCoord(x+5);
   m_buy_per.Width(30);
   m_buy_per.TextSize(10);
   m_buy_per.TextFont("Arial Black");
   m_buy_per.Text("#");
   m_buy_per.Show();
   m_elements.Add(GetPointer(m_buy_per));
   
   m_sell_per.XCoord(x+5);
   m_sell_per.Width(30);
   m_sell_per.TextSize(10);
   m_sell_per.TextFont("Arial Black");
   m_sell_per.Text("#");
   m_sell_per.Show();
   m_elements.Add(GetPointer(m_sell_per));
   
   CEventRefresh* refresh = new CEventRefresh();
   OnRefresh(refresh);
   delete refresh;
}
//+------------------------------------------------------------------+
//| Reutrns the total height (buy+sell) of ratio's histogram         |
//| The total height cannot exceed 200 points                        |
//+------------------------------------------------------------------+
int CBookFonRatio::GetHistPipsTotal(void)
{
   int total_height = (int)m_book.InfoGetInteger(MBOOK_DEPTH_TOTAL)*16;
   if(total_height > 200)
      return 200;
   if(total_height < 50)
      return 50;
   return total_height;
}
//+------------------------------------------------------------------+
//| Configure the buy's histogram                                    |
//+------------------------------------------------------------------+
void CBookFonRatio::OnShowBuyHist(void)
{
   double total_buy = (double)m_book.InfoGetInteger(MBOOK_BID_VOLUME_TOTAL);
   double total_sell = (double)m_book.InfoGetInteger(MBOOK_ASK_VOLUME_TOTAL);
   double total = total_buy + total_sell;
   double ratio_buy = 0.0;
   if(total > 0)
      ratio_buy = total_buy/total;
   long height = (long)(GetHistPipsTotal()*ratio_buy);
   long y_coord = m_book_line.YCoord();
   m_buy_hist.YCoord(y_coord);
   m_buy_hist.Height(height);
   m_buy_per.YCoord(m_book_line.YCoord()+5);
   m_buy_per.Text(DoubleToString(ratio_buy*100.0,0));
   long max_y = y_coord + height;
   if(YCoord()+Height() < max_y)
      Height(max_y);
}
//+------------------------------------------------------------------+
//| Configure the sell's histogram                                   |
//+------------------------------------------------------------------+
void CBookFonRatio::OnShowSellHist(void)
{
   double total_buy = (double)m_book.InfoGetInteger(MBOOK_BID_VOLUME_TOTAL);
   double total_sell = (double)m_book.InfoGetInteger(MBOOK_ASK_VOLUME_TOTAL);
   double total = total_buy + total_sell;
   double ratio_sell = 0.0;
   if(total > 0)
      ratio_sell = total_sell/(total);
   long height = (long)(GetHistPipsTotal()*ratio_sell);
   long y_coord = m_book_line.YCoord()-height;
   m_sell_hist.YCoord(y_coord);
   m_sell_hist.Height(height+1);
   m_sell_per.YCoord(m_book_line.YCoord()-20);
   m_sell_per.Text(DoubleToString(ratio_sell*100,0));
}
//+------------------------------------------------------------------+
//| Adds to the Depth of Market the histogram of total buy/sell      |
//+------------------------------------------------------------------+
void CBookFonRatio::OnRefresh(CEventRefresh *refresh)
{
   CBookFon::OnRefresh(refresh);
   OnShowSellHist();
   OnShowBuyHist();
}