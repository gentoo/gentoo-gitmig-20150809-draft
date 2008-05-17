# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/parcellite/parcellite-0.7.ebuild,v 1.1 2008/05/17 20:52:06 drac Exp $

DESCRIPTION="a lightweight GTK+ based clipboard manager."
HOMEPAGE="http://code.google.com/p/xyhthyx"
SRC_URI="http://xyhthyx.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.10"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	econf --disable-dependency-tracking --disable-gtktest
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS README
}
