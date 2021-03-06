//+------------------------------------------------------------------+
//|                                          EventChartPBRefresh.mqh |
//|                                 Copyright 2015, Vasiliy Sokolov. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2015, Vasiliy Sokolov."
#property link      "http://www.mql5.com"
#include "Event.mqh"
//+------------------------------------------------------------------+
//| The event updates the progress bar with the ID identifier        |
//| setting a new progress value                                     |
//+------------------------------------------------------------------+
class CEventChartPBRefresh : public CEvent
{
private:
   double         m_progress_bar_value;      // The value of the progress bar
   int            m_progress_bar_id;         // The identifier of the progress bar
public:
   CEventChartPBRefresh(int progressBarID, double progressValue);
   double ProgressBarValue(void);
   int ProgressBarID(void);
};
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CEventChartPBRefresh::CEventChartPBRefresh(int progressBarID,double progressValue) : CEvent(EVENT_CHART_PBAR_CHANGED)
{
   m_progress_bar_id = progressBarID;
   m_progress_bar_value = progressValue;      
}
//+------------------------------------------------------------------+
//| Returns the ID of the progress bar that should                   |
//| react to this event                                              |
//+------------------------------------------------------------------+
int CEventChartPBRefresh::ProgressBarID(void)
{
   return m_progress_bar_id;
}
//+------------------------------------------------------------------+
//| Returns the value of the progress bar that should                |
//| react to this event                                              |
//+------------------------------------------------------------------+
double CEventChartPBRefresh::ProgressBarValue(void)
{
   return m_progress_bar_value;
}