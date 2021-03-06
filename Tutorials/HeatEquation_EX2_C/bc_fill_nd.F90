module bc_fill_module

! since this is a .F90 file (instead of .f90) we run this through a C++ preprocessor
! for e.g., #if (BL_SPACEDIM == 1) statements.

  implicit none

  public

contains

  subroutine phifill(phi,phi_lo,phi_hi,domlo,domhi,delta,xlo,time,bc) &
       bind(C, name="phifill")

    use bl_fort_module, only : bl_spacedim, c_real

    implicit none

    integer      :: phi_lo(3),phi_hi(3)
    integer      :: bc(bl_spacedim,2)
    integer      :: domlo(3), domhi(3)
    real(c_real) :: delta(3), xlo(3), time
    real(c_real) :: phi(phi_lo(1):phi_hi(1),phi_lo(2):phi_hi(2),phi_lo(3):phi_hi(3))

#if (BL_SPACEDIM == 1)
       call filcc(phi,phi_lo(1),phi_hi(1),domlo,domhi,delta,xlo,bc)
#elif (BL_SPACEDIM == 2)
       call filcc(phi,phi_lo(1),phi_lo(2),phi_hi(1),phi_hi(2),domlo,domhi,delta,xlo,bc)
#else
       call filcc(phi,phi_lo(1),phi_lo(2),phi_lo(3),phi_hi(1),phi_hi(2),phi_hi(3),domlo,domhi,delta,xlo,bc)
#endif

  end subroutine phifill
  
end module bc_fill_module
