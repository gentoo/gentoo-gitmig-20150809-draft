# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/grdesktop/grdesktop-0.19.ebuild,v 1.1 2003/05/05 04:40:10 bcowan Exp $

DESCRIPTION="Gtk2 frontend for rdesktop"
HOMEPAGE="http://www.nongnu.org/grdesktop"
SRC_URI="http://savannah.nongnu.org/download/${PN}/${PN}.pkg/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

DEPEND=">=x11-libs/gtk+-2.0.6-r3
	>=net-misc/rdesktop-1.1.0.19.9.0
	>=app-text/docbook2X-0.6.1"

#RDEPEND=""

S="${WORKDIR}/${P}"

src_compile() {
	econf \
	    --with-keymap-path=/usr/share/rdesktop/keymaps || die "./configure failed"
	    
	emake || die
}

src_install() {
	einstall

	dodoc AUTHORS ABOUT-NLS COPYING ChangeLog INSTALL NEWS README TODO    
}
