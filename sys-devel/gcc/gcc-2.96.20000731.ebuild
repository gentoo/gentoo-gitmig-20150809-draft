# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc/gcc-2.96.20000731.ebuild,v 1.1 2000/11/11 16:26:19 achim Exp $

A="gcc-2.96-20000731.tar.bz2
   libg++-2.8.1.3.tar.gz
   libg++-2.8.1.3-20000312.diff.gz
   libg++-2.8.1.3-20000419.diff.gz
   libg++-2.8.1.3-20000816.diff.gz"

S=${WORKDIR}/gcc-2.96-20000731
T=/usr
DESCRIPTION="modern gcc c/c++ compiler"
SRC_URI="ftp://ftp.eos.hokudai.ac.jp/pub/Linux/Kondara/Jirai/SOURCES/gcc-2.96-20000731.tar.bz2
	 ftp://ftp.freesoftware.com/pub/sourceware/gcc/infrastructure/libg++-2.8.1.3.tar.gz
         ftp://ftp.freesoftware.com/pub/sourceware/gcc/infrastructure/libg++-2.8.1.3-20000312.diff.gz
         ftp://ftp.freesoftware.com/pub/sourceware/gcc/infrastructure/libg++-2.8.1.3-20000419.diff.gz
	 ftp://ftp.freesoftware.com/pub/sourceware/gcc/infrastructure/libg++-2.8.1.3-20000816.diff.gz"
HOMEPAGE="http://www.gnu.org/software/gcc/gcc.html"

src_unpack() {
    unpack gcc-2.96-20000731.tar.bz2
    cd ${S}
    for i in sparc64-subreg-byte sparc64-reload sparc64-startfile sparc64-decloffset \
             sparc64-uname sparc32-vaarg sparc64-hwint java-jword align-memcpy \
             sparcv9-hack c++-typedef no-warn-trigraphs incomplete-struct \
             libstdc++-v3-wnoerror string-crash
    do
      echo
      echo "Applying $i patch..."
      patch -p0 < ${FILESDIR}/${P}/gcc-$i.patch
    done
    # Here comes some sparc stuff. sparc32-hack sparc32-hack2
    for i in stmtexpr clear-hack loop alpha-addressof regmove-asm cpplib cpp0 canon-cond \
             bogus-subreg cp-ii subreg-gcse subregbyte-gcse combine-comparison \
             loop-noopt loop-unroll loop-test1 loop-test2 loop-scanloop i386-ashlsilea \
             i386-lea lowpart-test loop-noopt2 i386-sibcall cpp-warn wint_t \
             format-checking strftime xopen c99 iso-not-ansi sibcall Os-testcase \
             java-misc java-bytecode java-pg f-include unroll i386-strops \
             simplify-relational alias jsm1 jsm2 jsm3 scanf jsm4 jsm5 jsm6 \
             jsm7 jsm8 loop-hack cpp-warnpaste float-condmove i386-call \
             i386-call2 i386-call-test i386-arith i386-ge_geu i386-gotoff java-catchup \
             java-no-super-layout make-extraction segv1 segv2 sparc-copy-leaf-remappable \
             wchar-const libio alpha-tune alpha-unaligned cpp-warnpaste2 loop-giv \
             real-value sparc-const-pool sparc64-timode callersave-segv libio-printf_fp \
             pt-enum sparc-pic subreg-byte-expmed test-991206-1 alpha-mi-thunk c++-pmf \
             f77-fdebug libio-endl i386-compare-test sparc-may-trap sparc-mi-thunk \
             c++-inline16-test c++-named-return-value c++-walk-tree i386-reload-test \
             i386-reload sibcall-unchanging segv3 c++-crash24 do-store-flag \
             i386-address-cost i386-arith2 i386-constraint-N incomplete-aggregate-alias \
             sibcall-eh2 cpp-assert-crash c++-undefined-method sparc-4096 \
             sparc64-reload-test sparc64-reload2 subreg-byte-operand-subword \
             c++-binding-levels c++-static-class c++-testset1 c++-testset2 place-field \
             sparc-output-formatting sparc64-mi-thunk sparc64-namedret sparc64-nested-fn \
             c++-ice
    do
      echo
      echo "Applying $i patch..."
      patch -p0 < ${FILESDIR}/${P}/gcc-$i.patch
    done
    unpack libg++-2.8.1.3.tar.gz
    mv libg++-2.8.1.3/* .
    rmdir libg++-2.8.1.3
    patch -p0 < ${FILESDIR}/${P}/gcc-libg++-config.patch
    gzip -dc ${DISTDIR}/libg++-2.8.1.3-20000312.diff.gz | patch -p1
    gzip -dc ${DISTDIR}/libg++-2.8.1.3-20000419.diff.gz | patch -p1
    gzip -dc ${DISTDIR}/libg++-2.8.1.3-20000816.diff.gz | patch -p1


}


src_compile() {
	cd ${S}
	try ${S}/configure --prefix=${T} --enable-version-specific-runtime-libs \
		       --host=${CHOST} --enable-threads=posix --enable-shared \
		        --with-local-prefix=${T}/local --enable-nls --enable-haifa \
                        --disable-checking

	try make bootstrap-lean
        try make -C gcc CC=\"./xgcc -B ./ -O2\" proto
}

src_install() {      
	try make install prefix=${D}${T} mandir=${D}${T}/man \
		gxx_include_dir=${D}${T}/${CHOST}/include/g++ 
	cd ${FULLPATH}
	dodir /lib
	dosym	${T}/lib/gcc-lib/${CHOST}/2.96/cpp /lib/cpp
	dosym   /usr/bin/gcc /usr/bin/cc
	cd ${S}
	dodoc COPYING COPYING.LIB README FAQ MAINTAINERS
}





