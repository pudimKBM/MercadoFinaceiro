#include "Event.mqh"
///
///
///
class CEventChartMouseMove : public CEvent
{
private:
   long m_x_coord;           // X-coordinates of the mouse pointer
   long m_y_coord;           // Y-coordinates of the mouse pointer

   int  m_mask;              // Mask of pressed mouse buttons
   
public:
   CEventChartMouseMove(long x, long y, int mask);
   long XCoord(void);
   long YCoord(void);
   int Mask(void);
};
///
/// Constructor
///
CEventChartMouseMove::CEventChartMouseMove(long x, long y, int mask) : CEvent(EVENT_CHART_MOUSE_MOVE)
{
   m_x_coord = x;
   m_y_coord = y;
   m_mask = mask;
}
///
/// Returns the mask of pressed mouse buttons
///
int CEventChartMouseMove::Mask(void)
{
   return m_mask;
}
///
/// Returns the X coordinate
///
long CEventChartMouseMove::XCoord(void)
{
   return m_x_coord;
}
///
/// Returns the Y coordinate
///
long CEventChartMouseMove::YCoord(void)
{
   return m_y_coord;
}