# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/grdesktop/grdesktop-0.17.ebuild,v 1.4 2003/09/05 22:01:48 msterret Exp $

DESCRIPTION="Gtk2 frontend for rdesktop"
HOMEPAGE="http://www.nongnu.org/grdesktop"
SRC_URI="http://savannah.nongnu.org/download/${PN}/${PN}.pkg/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

IUSE=""

DEPEND=">=x11-libs/gtk+-2.0.6-r3
	>=net-misc/rdesktop-1.1.0.19.9.0
	>=app-text/docbook2X-0.6.1"

#RDEPEND=""

S="${WORKDIR}/${P}"

src_compile() {
	econf \
	    --host=${CHOST} \
	    --prefix=/usr \
	    --infodir=/usr/share/info \
	    --datadir=/usr/share \
	    --mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install() {
	einstall

	dodoc AUTHORS ABOUT-NLS COPYING ChangeLog INSTALL NEWS README TODO
}
