# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# /home/cvsroot/gentoo-x86/skel.build,v 1.7 2001/08/25 21:15:08 chadh Exp

S=${WORKDIR}
DESCRIPTION="Program for performing molecular dynamics simulations."
SRC_URI="ftp://ftp.earth.ox.ac.uk/pub/${P}.tar.gz"
#For lack of a better homepage
HOMEPAGE="http://sal.kachinatech.com/Z/2/MOLDY.html"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc
                X? ( x11-base/xfree )"

src_compile() {

        local myconf
        if [ -z "`use X`" ]
        then
                myconf="--without-x"
        fi

#Individuals may want to edit the OPT* variables below.
#From the READ.ME:
#You may need to  "hand-tune" compiler or optimization options,
#which may be specified by setting the OPT and OPT2 environment
#variables.  OPT2 is used to compile only the most performance-critical
#modules and usually will select a very high level of optimization.
#It should be safe to select an optimization which means "treat all
#function arguments as restricted pointers which are not aliased to
#any other object".  OPT is used for less preformance-critical modules
#and may be set to a lower level of optimization than OPT2. 
    
        OPT=${CFLAGS} OPT2=${CFLAGS} \
        ./configure --prefix=/usr \
                                --host=${CHOST} \
                                ${myconf} || die
        
        emake || die
	make moldy.pdf || die
}

src_install () {
        
	dodir /usr/bin
        make prefix=${D}/usr install || die
        rm Makefile.in configure.in config.h.in
        insinto /usr/share/${PN}/examples/
        doins *.in *.out control.*
        dodoc BENCHMARK COPYING READ.ME RELNOTES
	insinto /usr/share/doc/${P}/pdf
	newins moldy.pdf moldy-manual.pdf
        
}


