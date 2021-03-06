//+------------------------------------------------------------------+
//|                                                   MBookPanel.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2015, MetaQuotes Software Corp."
#property link      "http://www.mql5.com"
#include "Node.mqh"
#include "..\Events\EventChartEndEdit.mqh"

class CElEdit : public CNode
{
private:
   string m_text;
   long m_x;
   long m_y;
protected:
   virtual void OnEndEdit(CEventChartEndEdit* event){;}
public:
   virtual void Event(CEvent* event);
   CElEdit(long x, long y);
   virtual void Show();
   void Text(string text);
   string Text(void);
};

CElEdit::CElEdit(long x,long y)
{
   m_x = x;
   m_y = y;
}

CElEdit::Show(void)
{
   ObjectCreate(ChartID(), m_name, OBJ_EDIT, 0, 0, 0);
   ObjectSetInteger(ChartID(), m_name, OBJPROP_XDISTANCE, m_x);
   ObjectSetInteger(ChartID(), m_name, OBJPROP_YDISTANCE, m_y);
   ObjectSetInteger(ChartID(), m_name, OBJPROP_XSIZE, 100);
   ObjectSetString(ChartID(), m_name, OBJPROP_TEXT, m_text);
   ObjectSetInteger(ChartID(), m_name, OBJPROP_COLOR, FontColor);
   OnShow();
}

void CElEdit::Text(string text)
{
   m_text = text;
   if(IsShowed())
      ObjectSetString(ChartID(), m_name, OBJPROP_TEXT, m_text);
}

string CElEdit::Text(void)
{
   return m_text;
}
void CElEdit::Event(CEvent* event)
{
   if(event.EventType() == EVENT_CHART_END_EDIT)
   {
      CEventChartEndEdit* evEndEdit = event;
      if(evEndEdit.ObjectName() == m_name)
      {
         m_text = ObjectGetString(ChartID(), m_name, OBJPROP_TEXT);
         OnEndEdit(evEndEdit);
         return;
      }
   }
   CNode::Event(event);
}
