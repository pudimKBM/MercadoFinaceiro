//+------------------------------------------------------------------+
//|                                        EventChartListChanged.mqh |
//|                                 Copyright 2015, Vasiliy Sokolov. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2015, Vasiliy Sokolov."
#property link      "http://www.mql5.com"
#include "Event.mqh"
///
///
///
class CEventChartListChanged : public CEvent
{
private:
   string m_obj_name;
   
public:
   CEventChartListChanged(string name);
   string ListNameChanged(void);
};
///
/// Constructor
///
CEventChartListChanged::CEventChartListChanged(string obj_name) : CEvent(EVENT_CHART_LIST_CHANGED)
{
   m_obj_name = obj_name;
}
///
/// Returns the name of the clicked object 
///
string CEventChartListChanged::ListNameChanged(void)
{
   return m_obj_name;
}