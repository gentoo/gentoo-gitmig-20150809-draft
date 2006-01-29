OBJS = caxpy.o ccopy.o cdotc.o cdotu.o cgbmv.o cgemm.o cgemv.o cgerc.o	\
       cgeru.o chbmv.o chemm.o chemv.o cher.o cher2.o cher2k.o cherk.o	\
       chpmv.o chpr.o chpr2.o crotg.o cscal.o csrot.o csscal.o cswap.o	\
       csymm.o csyr2k.o csyrk.o ctbmv.o ctbsv.o ctpmv.o ctpsv.o		\
       ctrmm.o ctrmv.o ctrsm.o ctrsv.o dasum.o daxpy.o dcabs1.o		\
       dcopy.o ddot.o dgbmv.o dgemm.o dgemv.o dger.o dnrm2.o drot.o	\
       drotg.o drotm.o drotmg.o dsbmv.o dscal.o dsdot.o dspmv.o dspr.o	\
       dspr2.o dswap.o dsymm.o dsymv.o dsyr.o dsyr2.o dsyr2k.o dsyrk.o	\
       dtbmv.o dtbsv.o dtpmv.o dtpsv.o dtrmm.o dtrmv.o dtrsm.o dtrsv.o	\
       dzasum.o dznrm2.o icamax.o idamax.o isamax.o izamax.o lsame.o	\
       sasum.o saxpy.o scasum.o scnrm2.o scopy.o sdot.o sdsdot.o	\
       sgbmv.o sgemm.o sgemv.o sger.o snrm2.o srot.o srotg.o srotm.o	\
       srotmg.o ssbmv.o sscal.o sspmv.o sspr.o sspr2.o sswap.o ssymm.o	\
       ssymv.o ssyr.o ssyr2.o ssyr2k.o ssyrk.o stbmv.o stbsv.o stpmv.o	\
       stpsv.o strmm.o strmv.o strsm.o strsv.o xerbla.o zaxpy.o		\
       zcopy.o zdotc.o zdotu.o zdrot.o zdscal.o zgbmv.o zgemm.o		\
       zgemv.o zgerc.o zgeru.o zhbmv.o zhemm.o zhemv.o zher.o zher2.o	\
       zher2k.o zherk.o zhpmv.o zhpr.o zhpr2.o zrotg.o zscal.o zswap.o	\
       zsymm.o zsyr2k.o zsyrk.o ztbmv.o ztbsv.o ztpmv.o ztpsv.o		\
       ztrmm.o ztrmv.o ztrsm.o ztrsv.o

# libg2c is part of GNU gcc. It is listed here as a dependency for the F77
# BLAS libraries in case the user wants to link with the libraries using
# the Intel Fortran Compiler. The issue is with xerbla.f, which calls the
# STOP instrinsic. Linking with ifc will result in undefined symbols like
# e_wsfe and others. These symbols are contained in libg2c. If you are not
# using gcc, you most likely want to remove the '-lg2c' from libf77blas.so
# and possibly libptf77blas.so. Of course, you can just remove -lg2c, and
# specify it explicitly when using ifc.
libs: $(OBJS)
	libtool --tag=F77 --mode=link $(FC) $(FFLAGS) -o libblas.la *.lo $(LIBTOOL_FLAGS)

shared: $(OBJS)
	$(FC) -shared $(FFLAGS) -Wl,-soname,libblas.so.0 -o libblas.so.0.0.0 *.lo $(DEP_LIBS)

static: $(OBJS)
	ar cru libblas.a $(OBJS)
	ranlib libblas.a

clean:
	rm -f *.o libblas*

%.o : %.f
	libtool --tag=F77 --mode=compile $(FC) $(FFLAGS) -o $@ -c $^
