# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-eazel/gtk-engines-eazel-0.3-r1.ebuild,v 1.6 2004/03/03 16:21:47 foser Exp $

inherit gtk-engines2

MY_PN="eazel-engine"

IUSE=""
DESCRIPTION="GTK+1 Eazel Theme Engine"
SRC_URI="mirror://debian/pool/main/e/${MY_PN}/${MY_PN}_${PV}.orig.tar.gz"
KEYWORDS="x86 ~ppc sparc ~alpha hppa"
LICENSE="GPL-2"
SLOT="1"

DEPEND="=x11-libs/gtk+-1.2*
	media-libs/gdk-pixbuf
	=gnome-base/control-center-1.4*"

S=${WORKDIR}/${MY_PN}-${PV}

src_unpack() {

	unpack ${A}

	cd ${S}
	# ugly hack to get around the glade dep (#38045)
	echo 'int main(){return 0;}' > test.c

}
