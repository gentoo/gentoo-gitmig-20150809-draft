# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/rol/rol-0.2.2.ebuild,v 1.4 2006/05/02 01:35:48 weeve Exp $

DESCRIPTION="A RSS/RDF Newsreader"
HOMEPAGE="http://unknown-days.com/rol/"
SRC_URI="http://unknown-days.com/rol/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha ~amd64 ~hppa ppc sparc x86"
IUSE=""


DEPEND="dev-libs/libxml
	>=x11-libs/gtk+-2.0.9
	>=gnome-base/gconf-2"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e "s:-DGTK_DISABLE_DEPRECATED ::" src/Makefile
}

src_compile() {
	emake || die
}

src_install() {
	cd ${S}/src
	dobin rol
	cd ${S}
	dodoc AUTHORS ChangeLog README SITES
}
