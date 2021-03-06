//+------------------------------------------------------------------+
//|                                                   MBookPanel.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2015, MetaQuotes Software Corp."
#property link      "http://www.mql5.com"
#include <Trade\MarketBook.mqh>
#include <Panel\ElChart.mqh>

#define BOOK_PRICE 0
#define BOOK_VOLUME 1

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class CBookCeil : public CElChart
{
private:
   long              m_ydist;
   long              m_xdist;
   int               m_index;
   int               m_ceil_type;
   CElChart          m_text;
   CMarketBook      *m_book;
public:
                   CBookCeil(int type,long x_dist,long y_dist,int index_mbook,CMarketBook *book);
   virtual void    OnRefresh(CEventRefresh *event);
};

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CBookCeil::CBookCeil(int type,long x_dist,long y_dist,int index_mbook, CMarketBook *book) : CElChart(OBJ_RECTANGLE_LABEL),
                                                                                            m_text(OBJ_LABEL)
  {
   XCoord(x_dist);
   YCoord(y_dist);
   Height(16);
   Width(58);
   BorderType(BORDER_FLAT);
   
   m_index = index_mbook;
   m_book=book;
   m_ceil_type=type;
   
   m_text.XCoord(x_dist+2);
   m_text.YCoord(y_dist);
   m_text.Height(16);
   m_text.Width(58);
   m_text.TextColor(clrBlack);
   m_text.TextSize(9);
   m_text.BorderType(BORDER_FLAT);
   m_elements.Add(GetPointer(m_text));
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CBookCeil::OnRefresh(CEventRefresh *event)
  {
   ENUM_BOOK_TYPE type=m_book.MarketBook[m_index].type;
   long max_volume=0;
   if(type==BOOK_TYPE_BUY || type==BOOK_TYPE_BUY_MARKET)
     {
      BackgroundColor(clrCornflowerBlue);
      max_volume=m_book.InfoGetInteger(MBOOK_MAX_BID_VOLUME);
     }
   else if(type==BOOK_TYPE_SELL || type==BOOK_TYPE_SELL_MARKET)
     {
      BackgroundColor(clrPink);
      max_volume=m_book.InfoGetInteger(MBOOK_MAX_ASK_VOLUME);
     }
   else
      BackgroundColor(clrWhite);
   MqlBookInfo info=m_book.MarketBook[m_index];
   if(m_ceil_type==BOOK_PRICE)
      m_text.Text(DoubleToString(info.price,Digits()));
   else if(m_ceil_type==BOOK_VOLUME)
      m_text.Text((string)info.volume);
   if(m_ceil_type != BOOK_VOLUME)
      return;
   
   double delta=1.0;
   if(max_volume>0)
      delta=(info.volume/(double)max_volume);
   if(delta>1.0)delta=1.0;
   long size=(long)(delta*50.0);
   if(size==0)size=1;
   Width(size);
  }
//+------------------------------------------------------------------+
