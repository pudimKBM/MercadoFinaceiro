//+------------------------------------------------------------------+
//|                                                   MBookPanel.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2015, MetaQuotes Software Corp."
#property link      "http://www.mql5.com"
#include "Node.mqh"
#include "ElLabel.mqh"
#include "..\Events\EventChartObjClick.mqh"

class CElCheckBox : public CElLabel
{
private:
   bool m_checked;
protected:
   virtual void OnCheck(bool checked){;}
public:
   CElCheckBox(long x, long y);
   virtual void Show();
   virtual void Event(CEvent* event);
   void Checked(bool check);
};

CElCheckBox::CElCheckBox(long x, long y):CElLabel(CharToString(0xA8), x, y)
{
   m_checked = false;   
}

CElCheckBox::Show(void)
{
   CElLabel::Show();
   ObjectSetString(ChartID(), m_name, OBJPROP_FONT, "Wingdings");
   if(m_checked)
      ObjectSetString(ChartID(), m_name, OBJPROP_TEXT, CharToString(0xFE));
   else
      ObjectSetString(ChartID(), m_name, OBJPROP_TEXT, CharToString(0xA8));
   OnShow();
   FontSize(12);
}
///
///
///
void CElCheckBox::Event(CEvent* event)
{
   if(event.EventType() == EVENT_CHART_OBJECT_CLICK)
   {
      CEventChartObjClick* objClick = event;
      if(objClick.ObjectName() != m_name)return;
      if(m_checked)
         m_checked = !ObjectSetString(ChartID(), m_name, OBJPROP_TEXT, CharToString(0xA8));
      else
         m_checked = ObjectSetString(ChartID(), m_name, OBJPROP_TEXT, CharToString(0xFE));
      OnCheck(m_checked);
   }
   CNode::Event(event);
}

void CElCheckBox::Checked(bool check)
{
   m_checked = check;
   if(m_checked)
      ObjectSetString(ChartID(), m_name, OBJPROP_TEXT, CharToString(0xFE));
   else
      ObjectSetString(ChartID(), m_name, OBJPROP_TEXT, CharToString(0xA8));
}