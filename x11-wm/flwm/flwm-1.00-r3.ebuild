# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-wm/flwm/flwm-1.00-r3.ebuild,v 1.1 2002/08/12 14:33:30 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A lightweight window manager based on fltk"
SRC_URI="http://flwm.sourceforge.net/${P}.tgz"
HOMEPAGE="http://flwm.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 -ppc"


DEPEND=">=x11-base/xfree-4.0.1
	=x11-libs/fltk-1.0*
	opengl? ( virtual/opengl )"

	#Configuration of the appearance and behavior of flwm
	#must be done at compile time, i.e. there is 
	#no .flwmrc file or interactive configuring while 
	#running. To quote the man page, "gcc is your friend,"
	#so this type of configuration must be done at compile
	#time by editing the config.h file.  I can't see any
	#way to do this automagically so we'll echo a message
	#in pkg_postinst to tell the user to 'ebuild unpack'
	#and edit the config.h to their liking.

src_compile() {
    
	use opengl && export X_EXTRA_LIBS=-lGL
	
	export CXXFLAGS="${CXXFLAGS} -I/usr/include/fltk-1.0"
	export LIBS="-L/usr/lib/fltk-1.0"
	
	econf || die
	make || die
}

src_install() {
    
	doman flwm.1
	dodoc README flwm_wmconfig
    
	into /usr
	dobin flwm
}

pkg_postinst() {

	echo "**********************************************"
	echo "Customization of behaviour and appearance of"
	echo "flwm requires manually editing the config.h"
	echo "source file.  If you want to change the defaults,"
	echo "Do the following:"
	echo ""
	echo "ebuild ${P}.ebuild unpack"
	echo "${EDITOR} ${S}/config.h "
	echo "ebuild ${P} compile install qmerge"
	echo ""
	echo "**********************************************"

}
