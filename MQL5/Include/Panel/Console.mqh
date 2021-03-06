//+------------------------------------------------------------------+
//|                                                      Console.mqh |
//|                                 Copyright 2015, Vasiliy Sokolov. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2015, Vasiliy Sokolov."
#property link      "http://www.mql5.com"
#include "Node.mqh"
#include "ElChart.mqh"
#include <Arrays\List.mqh>
#include <Panel\Events\EventChartConsoleAdd.mqh>
#include <Panel\Events\EventChartConsoleChange.mqh>
#include <Panel\Events\EventChartConsoleChLast.mqh>
//+------------------------------------------------------------------+
//| Graphic element Console                                          |
//+------------------------------------------------------------------+
class CElConsole : public CElChart
{
private:
   CList    m_lines;
   int      m_lines_count;
   int      m_id;
   void     ReprintAll(void);
public:
   CElConsole(void);
   virtual void Event(CEvent* event);
   void ConsoleID(int id);
   void SetLinesCount(int total);
   void AddMessage(string msg);
   void ChangeMessage(string msg, int line_number);
   void ChangeLast(string msg);
};
//+------------------------------------------------------------------+
//| Default constructor                                              |
//+------------------------------------------------------------------+
CElConsole::CElConsole(void) : CElChart(OBJ_RECTANGLE_LABEL)
{
   SetLinesCount(10);
}
//+------------------------------------------------------------------+
//| Sets the numberer of lines                                       |
//+------------------------------------------------------------------+
void CElConsole::SetLinesCount(int total)
{
   m_lines_count = total;
}
void CElConsole::ConsoleID(int id)
{
   m_id = id;
}
void CElConsole::AddMessage(string msg)
{
   CElChart* line = new CElChart(OBJ_EDIT);
   line.Text(msg);
   line.BorderColor(BackgroundColor());
   line.BackgroundColor(BackgroundColor());
   line.TextSize(8);
   line.TextFont("Consolas");
   m_lines.Add(line);
   if(m_lines.Total() > m_lines_count)
      m_lines.Delete(0);
   ReprintAll();
}

void CElConsole::ChangeMessage(string msg,int line_number)
{
   if(line_number >= m_lines.Total())
   {
      AddMessage(msg);
      return;
   }
   CElChart* line = m_lines.GetNodeAtIndex(line_number);
   line.Text(msg);
   ReprintAll();
}

void CElConsole::ChangeLast(string msg)
{
   if(m_lines.Total() == 0)
   {
      AddMessage(msg);
      return;
   }
   CElChart* line = m_lines.GetLastNode();
   line.Text(msg);
   ReprintAll();
}


void CElConsole::ReprintAll(void)
{
   int i = 0;
   int height_line = 15;
   for(CElChart* node = m_lines.GetFirstNode(); node != NULL; node = m_lines.GetNextNode(), i++)
   {
      node.Hide();
      node.XCoord(XCoord()+1);
      node.YCoord(YCoord()+1 + (i*height_line));
      node.Height(height_line);
      node.Width(Width()-2);
      node.Show();
   }
}

void CElConsole::Event(CEvent* event)
{
   CElChart::Event(event);
   if(event.EventType() == EVENT_CHART_CONSOLE_ADD)
   {
      CEventCharConsoleAdd* cAdd = event;
      if(cAdd.ConsoleID() == m_id)
            AddMessage(cAdd.Message());
   }
   else if(event.EventType() == EVENT_CHART_CONSOLE_CHANGE)
   {
      CEventCharConsoleChange* cChange = event;
      ChangeMessage(cChange.Message(), cChange.LineNumber());
   }
   else if(event.EventType() == EVENT_CHART_CONSOLE_CHLAST)
   {
      CEventCharConsoleChLast* cChange = event;
      ChangeLast(cChange.Message());
   }
}