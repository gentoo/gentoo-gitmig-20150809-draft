# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2              
# $Header: /var/cvsroot/gentoo-x86/x11-misc/idesk/idesk-0.5.5.ebuild,v 1.1 2003/06/09 13:24:17 bcowan Exp $                                                                    

DESCRIPTION="Utility to place icons on the root window"                         
HOMEPAGE="http://idesk.timmfin.net"                           
SRC_URI="http://idesk.timmfin.net/releases/${P}.tar.gz"                  
                                                                                
LICENSE="BSD"                                                                   
SLOT="0"                                                                        
KEYWORDS="~x86 ~ppc"
                                                                                
DEPEND=">media-libs/imlib-1.9.14
	virtual/x11
	media-libs/freetype
	>=gnome-base/librsvg-2.2.5
	>=dev-util/pkgconfig-0.12.0
	dev-libs/libxml2
	=dev-libs/glib-2*
	gnome-extra/libgsf
	=x11-libs/pango-1*
	=x11-libs/gtk+-2*
	media-libs/libart_lgpl"

S="${WORKDIR}"                                                            

src_unpack() {
	unpack ${A}
	cd ${S}

	#Allow for more robust CXXFLAGS
	mv Makefile Makefile.orig
	sed -e "s:= -g -W #-Wall:= ${CXXFLAGS}:" Makefile.orig > Makefile
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
