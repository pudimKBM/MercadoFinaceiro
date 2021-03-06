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
#include "MBookFonRatio.mqh"
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
           void      SetMarketBookSymbol(string symbol);
   virtual void      Refresh();
   virtual void      Event(int id,long lparam,double dparam,string sparam);
           void      Clear(void);
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
   // config form
   if(CheckPointer(m_book_panel) != POINTER_INVALID)
      delete m_book_panel;   
   #ifdef SHOW_BOOK_RATIO   
      m_book_panel = new CBookFonRatio(GetPointer(m_book));
      m_book_panel.Width(176);   
   #else
      m_book_panel = new CBookFon(GetPointer(m_book));
      m_book_panel.Width(116);
   #endif
      
      m_elements.Add(m_book_panel);
   m_book_panel.YCoord(YDistance + Height() + 3);
   m_book_panel.XCoord(XDistance);
   m_book_panel.BorderType(BORDER_FLAT);
   m_book_panel.BackgroundColor(clrWhite);
  }
  
CBookPanel::SetMarketBookSymbol(string symbol)
{
   m_book.SetMarketBookSymbol(symbol);
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
//| Inhibit the output of Depth of Market's child controls  until the moment of button  |
//| press                                                            |
//+------------------------------------------------------------------+
void CBookPanel::OnShow(void)
{
}