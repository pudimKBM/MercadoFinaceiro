//+------------------------------------------------------------------+
//|                                                   MBookPanel.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2015, MetaQuotes Software Corp."
#property link      "http://www.mql5.com"
#include "Node.mqh"
#include <Dictionary.mqh>


class CFon : public CNode
{
private:
   long        m_x;
   long        m_y;
   long        m_x_dist;
   long        m_y_dist;
   color       m_bg_color;
public:
   CFon();
   CFon(color bgColor, long x_size, long y_size, long x_dist, long y_dist);
   virtual void Show();
   virtual void Refresh(void){;}
   
};
CFon::CFon(void)
{
   m_x = 340;
   m_y = 160;
   m_x_dist = 13;
   m_y_dist = 6;
}
CFon::CFon(color bgColor, long x_size, long y_size, long x_dist, long y_dist)
{  
   m_x = x_size;
   m_y = y_size;
   m_x_dist = x_dist;
   m_y_dist = y_dist;
   m_bg_color = bgColor;
}
CFon::Show(void)
{
   ObjectCreate(ChartID(), m_name, OBJ_RECTANGLE_LABEL, 0, 0, 0);
   ObjectSetInteger(ChartID(), m_name, OBJPROP_YDISTANCE, m_y_dist);
   ObjectSetInteger(ChartID(), m_name, OBJPROP_XDISTANCE, m_x_dist);
   ObjectSetInteger(ChartID(), m_name, OBJPROP_XSIZE, m_x);
   ObjectSetInteger(ChartID(), m_name, OBJPROP_BORDER_TYPE, BORDER_FLAT);
   ObjectSetInteger(ChartID(), m_name, OBJPROP_BGCOLOR, m_bg_color);
   ObjectSetInteger(ChartID(), m_name, OBJPROP_YSIZE, m_y);
   OnShow();
}