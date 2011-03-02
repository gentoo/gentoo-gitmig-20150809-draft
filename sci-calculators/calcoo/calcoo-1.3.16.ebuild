# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/calcoo/calcoo-1.3.16.ebuild,v 1.7 2011/03/02 13:26:37 jlec Exp $

EAPI="1"

DESCRIPTION="Scientific calculator designed to provide maximum usability"
HOMEPAGE="http://calcoo.sourceforge.net/"
SRC_URI="mirror://sourceforge/calcoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2"
DEPEND="${RDEPEND}
		dev-util/pkgconfig"

src_compile() {
	econf --disable-gtktest || die "econf failed."
	emake || die "emake failed."
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed."
	dodoc AUTHORS ChangeLog NEWS README TODO
}
