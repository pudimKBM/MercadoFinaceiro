//+------------------------------------------------------------------+
//|                                                   MBookPanel.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2015, MetaQuotes Software Corp."
#property link      "http://www.mql5.com"
#include "ElChart.mqh"

class CElLabel : public CElChart
{
public:
   CElLabel(string text, long x, long y);
   CElLabel(string text, long x, long y, int font_size);
   virtual void Show();
};
///
/// Creates a text label on the coordinates x, y, containing text
///
CElLabel::CElLabel(string text,long x,long y): CElChart(OBJ_LABEL)
{
   XCoord(x);
   YCoord(y);
   Text(text);
}


CElLabel::Show(void)
{
   ObjectCreate(ChartID(), m_name, OBJ_LABEL, 0, 0, 0);
   ObjectSetInteger(ChartID(), m_name, OBJPROP_XDISTANCE, XCoord());
   ObjectSetInteger(ChartID(), m_name, OBJPROP_YDISTANCE, YCoord());
   ObjectSetString(ChartID(), m_name, OBJPROP_TEXT, Text());
   ObjectSetInteger(ChartID(), m_name, OBJPROP_COLOR, FontColor);
   OnShow();
}

class CElHorLine : public CElChart
{
private:
   long m_size;
public:
   CElHorLine(long x, long y, long size) : CElChart(OBJ_RECTANGLE_LABEL)
   {
      XCoord(x);
      YCoord(y);
      m_size = size;
   }
   virtual void Show()
   {
      ObjectCreate(ChartID(), m_name, OBJ_RECTANGLE_LABEL, 0, 0, 0);
      ObjectSetInteger(ChartID(), m_name, OBJPROP_XDISTANCE, XCoord());
      ObjectSetInteger(ChartID(), m_name, OBJPROP_YDISTANCE, YCoord());
      ObjectSetInteger(ChartID(), m_name, OBJPROP_YSIZE, 1);
      ObjectSetInteger(ChartID(), m_name, OBJPROP_BGCOLOR, clrBlack);
      ObjectSetInteger(ChartID(), m_name, OBJPROP_XSIZE, m_size);
   }
};