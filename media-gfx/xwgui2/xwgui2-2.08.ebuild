# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/xwgui2/xwgui2-2.08.ebuild,v 1.2 2004/04/05 17:14:23 plasmaroo Exp $

DESCRIPTION="xwGUI2 is an image and photo layout application aimed for printing"
HOMEPAGE="http://xwgui.automatix.de/"
SRC_URI="http://xwgui.automatix.de/daten/xwgui-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
DEPEND="virtual/x11
	>=x11-libs/xforms-1.0
	>=media-libs/t1lib-1.0"

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
