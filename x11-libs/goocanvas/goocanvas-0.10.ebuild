# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/goocanvas/goocanvas-0.10.ebuild,v 1.2 2008/12/14 22:57:07 eva Exp $

inherit libtool

DESCRIPTION="GooCanvas is a canvas widget for GTK+ using the cairo 2D library for drawing."
HOMEPAGE="http://sourceforge.net/projects/goocanvas"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.10
	x11-libs/cairo"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Fails to build with recent GTK+
	sed -e "s/-D.*_DISABLE_DEPRECATED//g" \
		-i src/Makefile.am src/Makefile.in demo/Makefile.am demo/Makefile.in \
		|| die "sed failed"

	# Needed for FreeBSD - Please do not remove
	elibtoolize
}

src_compile() {
	econf --disable-dependency-tracking --disable-gtk-doc
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README TODO
}
