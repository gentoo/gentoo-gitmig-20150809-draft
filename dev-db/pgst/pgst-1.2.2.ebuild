# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/pgst/pgst-1.2.2.ebuild,v 1.3 2008/05/21 15:57:04 dev-zero Exp $

inherit gnome2

DESCRIPTION="An intuitive GUI (GTK-based) for PostgreSQL management"
HOMEPAGE="http://www.sourceforge.net/projects/pgst/"
SRC_URI="mirror://sourceforge/pgst/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="virtual/postgresql-server"

RDEPEND="${DEPEND}
	dev-util/glade
	dev-python/pygtk"

S="${WORKDIR}/pgst/pgst"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}/pgst
	tar -xpf setup.tar
	sed -i -e 's/python2\.2/python/g;' pgst/pgst.py* || die
	sed -i -e 's:cd .*:cd /usr/share/pgst:g;' pgst/pgst.sh || die
}

src_compile() {
	:
}

src_install() {
	dobin pgst.sh

	dosym /usr/bin/pgst.sh /usr/bin/pgst

	insinto /usr/share/pgst
	doins pgst.glade pgst.py

	insinto /usr/share/pgst/pixmaps
	doins pixmaps/*

	dodoc *.txt

	insinto /usr/share/applications
	newins ${FILESDIR}/${P}.desktop ${PN}.desktop
}
