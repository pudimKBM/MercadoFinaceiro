//+------------------------------------------------------------------+
//|                                                   MBookPanel.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2015, MetaQuotes Software Corp."
#property link      "http://www.mql5.com"
#include <Trade\MarketBook.mqh>
#include <Panel\ElButton.mqh>
#include <Panel\Events\EventRefresh.mqh>
#include "MBookFon.mqh"

input int XDistance = 120;
input int YDistance = 0;

//+------------------------------------------------------------------+
//| CBookPanel class                                                 |
//+------------------------------------------------------------------+
class CBookPanel : public CElButton
  {
private:
   CMarketBook       m_book;
   CBookFon*         m_book_panel;
   bool              m_showed;
   
public:
                     CBookPanel();
                    ~CBookPanel();
   virtual void      Refresh();
   virtual void      Event(int id,long lparam,double dparam,string sparam);
   virtual void      OnShow(void);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CBookPanel::CBookPanel()
  {
   m_book.Refresh();
   // Config Main button
   Width(17);
   Height(17);
   XCoord(XDistance);
   YCoord(YDistance);
   TextFont("Webdings");
   Text(CharToString(0x36));
   // config MarketBook form
   m_book_panel = new CBookFon(GetPointer(m_book));
   m_book_panel.YCoord(YDistance + Height() + 3);
   m_book_panel.XCoord(XDistance);
   m_book_panel.Width(116);
   m_book_panel.BorderType(BORDER_FLAT);
   m_book_panel.BackgroundColor(clrWhite);
   int total=(int)m_book.InfoGetInteger(MBOOK_DEPTH_TOTAL);
   m_book_panel.Height(total*15+16);
   m_elements.Add(m_book_panel);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CBookPanel::~CBookPanel(void)
  {
   OnHide();
   ObjectDelete(ChartID(),m_name);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CBookPanel::Event(int id,long lparam,double dparam,string sparam)
  {
   switch(id)
     {
      case CHARTEVENT_OBJECT_CLICK:
        {
         if(sparam != m_name)return;
         m_book.Refresh();
         if(State() == PUSH_ON)
            m_book_panel.Show();
         else
            m_book_panel.Hide();
         m_showed=!m_showed;
        }
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CBookPanel::Refresh()
  {
   m_book.Refresh();
   CEventRefresh* refresh = new CEventRefresh();
   m_book_panel.Event(refresh);
   delete refresh;
  }
//+------------------------------------------------------------------+
void CBookPanel::OnShow(void)
{
}