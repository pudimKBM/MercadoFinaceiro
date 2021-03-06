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

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class CBookFon : public CElChart
  {
protected:
   CMarketBook      *m_book;
   CElChart          m_book_line;         // Depth of market separation line  
   long              m_prev_ask_total;    // Previous depth of Ask
   long              m_prev_bid_total;    // Previous depth of Bid
public:
                     CBookFon(CMarketBook *book);
   virtual void      OnShow();
   virtual void      OnRefresh(CEventRefresh* refresh);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CBookFon::CBookFon(CMarketBook *book) : CElChart(OBJ_RECTANGLE_LABEL),
                                        m_book_line(OBJ_RECTANGLE_LABEL)
{
   m_book=book;
   m_prev_ask_total = -1;
   m_prev_bid_total = -1;
}
//+------------------------------------------------------------------+
//| If number of controls was changed, then redraw Depth of Market    |
//+------------------------------------------------------------------+
void CBookFon::OnRefresh(CEventRefresh *refresh)
{
   if(!IsShowed())
      return;
   if(m_book.InfoGetInteger(MBOOK_DEPTH_ASK)!=m_prev_ask_total ||
      m_book.InfoGetInteger(MBOOK_DEPTH_BID)!=m_prev_bid_total)
   {
      Hide();
      m_elements.Clear();
      Show();
   }
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CBookFon::OnShow(void)
{
   m_book.Refresh();
   m_elements.Clear();
   int total = (int)m_book.InfoGetInteger(MBOOK_DEPTH_TOTAL);
   CEventRefresh* refresh = new CEventRefresh();
   for(int i = 0; i < total; i++)
     {
      CBookCeil *Ceil=new CBookCeil(0,XCoord()+3,i*15+10+YCoord(),i,m_book);
      CBookCeil *CeilVol=new CBookCeil(1,XCoord()+63,i*15+10+YCoord(),i,m_book);
      m_elements.Add(Ceil);
      m_elements.Add(CeilVol);
      Ceil.Show();
      CeilVol.Show();
      Ceil.OnRefresh(refresh);
      CeilVol.OnRefresh(refresh);
     }
   delete refresh;
   long best_bid=m_book.InfoGetInteger(MBOOK_BEST_BID_INDEX);
   long y=best_bid*15+YCoord()+10;
   m_book_line.YCoord(y);
   m_book_line.XCoord(XCoord());
   m_book_line.Width(Width());
   m_book_line.Height(1);
   m_book_line.BackgroundColor(clrBlack);
   m_book_line.BorderColor(clrBlack);
   m_book_line.BorderType(BORDER_FLAT);
   m_book_line.Show();
   m_elements.Add(GetPointer(m_book_line));
   m_prev_ask_total = m_book.InfoGetInteger(MBOOK_DEPTH_ASK);
   m_prev_bid_total = m_book.InfoGetInteger(MBOOK_DEPTH_BID);
   int need_height = total*15+20;
   if(Height() < need_height)
      Height(need_height);
}
//+------------------------------------------------------------------+
