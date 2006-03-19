# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/xwgui2/xwgui2-2.08.ebuild,v 1.6 2006/03/19 23:11:44 joshuabaergen Exp $

DESCRIPTION="xwGUI2 is an image and photo layout application aimed for printing"
HOMEPAGE="http://xwgui.automatix.de/"
SRC_URI="http://xwgui.automatix.de/daten/xwgui-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"

IUSE=""
DEPEND="|| ( x11-libs/libXpm virtual/x11 )
	>=x11-libs/xforms-1.0
	=media-libs/t1lib-1*"

S="${WORKDIR}/xwGUI"

src_compile() {

	echo ">>> Compiling..."
	echo
	echo "    0% |=========================================================| 100%"
	echo -n "        "

	patch -p0 -s < ${FILESDIR}/xwgui2-${PV}-makefilediff.patch || die

	# This sorts out "invisible" input boxes due to a known
	# XForms bug...
	sed -e 's/20,xwGR/23,xwGR/' -i xwGUI/*.c || die

	cd xwGUI || die
	sed -e 's:/usr/X11R6/lib/libforms.so.1.0:/usr/lib/libforms.so.1:' -i Makefile || die
	emake || die
	echo
	echo

	if [ -x /usr/bin/gimp-1.2 ]; then
		echo ">>> Compiling GIMP plugin..."
		cd ../xwprint2 || die
		echo -n "    "; emake || die
	fi

}

src_install() {

	einstall || die
	if [ -x /usr/bin/gimp-1.2 ]; then
		cd xwprint2 || die

		insinto /usr/lib/gimp/1.2/plug-ins
		doins xwprint2

		insinto /usr/share/gimp/1.2
		doins xwprint2rc
	fi

}
