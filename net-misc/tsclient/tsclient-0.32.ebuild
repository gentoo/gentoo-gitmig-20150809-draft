# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/tsclient/tsclient-0.32.ebuild,v 1.3 2003/02/13 15:08:57 vapier Exp $

DESCRIPTION="Gtk2 frontend for rdesktop"
HOMEPAGE="http://www.gnomepro.com/tsclient"
SRC_URI="http://www.gnomepro.com/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

IUSE=""

DEPEND=">=x11-libs/gtk+-2.0.6-r3
	>=net-misc/rdesktop-1.1.0.19.9.0
	>=dev-libs/glib-2*"

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

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README VERSION   
}
