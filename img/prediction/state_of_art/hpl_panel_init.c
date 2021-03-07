#define    HPL_PTR( ptr_, al_ ) \
    ( ( ( (size_t)(ptr_)+(al_)-1 ) / (al_) ) * (al_) ) 
// [...]
PANEL->WORK  = (void *)malloc( (size_t)(lwork) * sizeof(double) );
// [...]
PANEL->L2    = (double *)HPL_PTR( PANEL->WORK, dalign );
PANEL->ldl2  = Mmax( 1, ml2 );
PANEL->L1    = PANEL->L2 + ml2 * JB;
PANEL->DPIV  = PANEL->L1   + JB * JB;
PANEL->DINFO = PANEL->DPIV + JB;     *(PANEL->DINFO) = 0.0;
PANEL->U     = ( nprow > 1 ? PANEL->DINFO + 1 : NULL );
