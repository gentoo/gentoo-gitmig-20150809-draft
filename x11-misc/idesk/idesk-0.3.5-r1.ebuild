# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2              
# $Header: /var/cvsroot/gentoo-x86/x11-misc/idesk/idesk-0.3.5-r1.ebuild,v 1.5 2003/04/22 06:00:05 mkeadle Exp $                                                                    
DESCRIPTION="Utility to place icons on the root window"                         
                                                                                
HOMEPAGE="http://linuxhelp.hn.org/idesk.php"                           
SRC_URI="http://linuxhelp.hn.org/${P}.tar.gz"                  
                                                                                
LICENSE="BSD"                                                                   
SLOT="0"                                                                        
KEYWORDS="x86 ~ppc"
                                                                                
DEPEND=">media-libs/imlib-1.9.14
	virtual/x11
	media-libs/freetype"

S="${WORKDIR}/${P}"                                                            

src_unpack() {
	unpack ${A}
	cd ${S}

	# fix for xft2 the ugly way	
	CXXFLAGS="${CXXFLAGS} -I/usr/include/freetype2 -U__linux__"
	#Allow for more robust CXXFLAGS
	mv Makefile Makefile.orig
	sed -e "s:-g -O2:${CXXFLAGS}:" Makefile.orig > Makefile
}

src_compile() {
	emake || die
}	

src_install() {                                                                
	exeinto /usr/bin
	doexe idesk	                                  
	dodoc README
}                                                                               

pkg_postinst() {
	einfo
	einfo "NOTE: Please refer to ${HOMEPAGE}"
	einfo "NOTE: For info on configuring ${PN}"
	einfo
}	
