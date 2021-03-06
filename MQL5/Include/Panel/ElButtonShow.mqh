//+------------------------------------------------------------------+
//|                                                   MBookPanel.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2015, MetaQuotes Software Corp."
#property link      "http://www.mql5.com"
#include "Node.mqh"
#include "..\FPanel.mqh"
#include "..\Events\Event.mqh"
#include "..\Events\EventChartObjClick.mqh"
#include "..\FElements.mqh"
///
/// Button for maximizing the main panel F-Panel
///
class CElButtonShow : public CNode
{
private:
   CFPanel* m_panel;
   CCryptoFon m_crypto;
public:
   CElButtonShow();
   ~CElButtonShow();
   virtual void Show();
   virtual void Event(CEvent* event);
};

CElButtonShow::CElButtonShow(void)
{
   m_panel = new CFPanel();
   m_elements.Add(m_panel);
   m_elements.Add(GetPointer(m_crypto));
   Show();
}
///
/// 
///
CElButtonShow::~CElButtonShow()
{
   m_crypto.Hide();
}
///
/// Configures and displays the button
///
CElButtonShow::Show(void)
{
   ObjectCreate(ChartID(), m_name, OBJ_BUTTON, 0, 0, 0);
   ObjectSetInteger(ChartID(), m_name, OBJPROP_YDISTANCE, 0);
   ObjectSetInteger(ChartID(), m_name, OBJPROP_XDISTANCE, 80);
   ObjectSetInteger(ChartID(), m_name, OBJPROP_XSIZE, 18);
   ObjectSetInteger(ChartID(), m_name, OBJPROP_YSIZE, 18);
   ObjectSetString(ChartID(), m_name, OBJPROP_FONT, "Webdings");
   ObjectSetInteger(ChartID(), m_name, OBJPROP_FONTSIZE, 12);
   ObjectSetString(ChartID(), m_name, OBJPROP_TEXT, CharToString(0x36));
   if(!m_crypto.IsEntryPassword())
      m_crypto.Show();
}

void CElButtonShow::Event(CEvent* event)
{
   
   if(event.EventType() == EVENT_CHART_OBJECT_CLICK)
   {
      CEventChartObjClick* objClick = event;
      if(objClick.ObjectName() == m_name)
      {
         bool state = ObjectGetInteger(ChartID(), m_name, OBJPROP_STATE);
         if(state)
         {
            ObjectSetString(ChartID(), m_name, OBJPROP_TEXT, CharToString(0x35));
            if(m_crypto.IsEntryPassword())
               m_panel.Show();
            else
            { 
               ObjectSetString(ChartID(), m_name, OBJPROP_TEXT, CharToString(0x36));
               ObjectSetInteger(ChartID(), m_name, OBJPROP_STATE, false);
            }
         }
         else
         {
            ObjectSetString(ChartID(), m_name, OBJPROP_TEXT, CharToString(0x36));
            m_panel.Hide();
         }
         return;      
      }
   }
   CNode::Event(event);
}