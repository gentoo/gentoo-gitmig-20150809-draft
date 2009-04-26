# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/tkdvd/tkdvd-4.0.9.ebuild,v 1.1 2009/04/26 20:15:28 patrick Exp $

DESCRIPTION="A Tcl/Tk GUI for writing DVDs and CDs"
HOMEPAGE="http://regis.damongeot.free.fr/tkdvd/"
SRC_URI="http://regis.damongeot.free.fr/tkdvd/dl/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="virtual/cdrtools
	 app-cdr/dvd+rw-tools
	 dev-lang/tcl
	 dev-lang/tk"

S=${WORKDIR}/tkdvd

src_compile() { :; }

src_install() {
	insinto /usr/share/${PF}/src
	doins src/* || die "doins failed."

	exeinto /usr/share/${PF}
	doexe TkDVD.sh || die "doexe failed."

	dodir /usr/bin

	cat <<EOF >"${D}"/usr/bin/tkdvd
#!/bin/sh
cd /usr/share/${PF}
./TkDVD.sh
EOF

	fperms 755 /usr/bin/tkdvd

	dodoc ChangeLog FAQ README TODO doc/config_file
	dohtml doc/combobox.html

	insinto /usr/share/pixmaps
	doins icons/*.png
}
