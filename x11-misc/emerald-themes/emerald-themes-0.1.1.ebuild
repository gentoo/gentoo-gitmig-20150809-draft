# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/emerald-themes/emerald-themes-0.1.1.ebuild,v 1.1 2006/10/22 22:15:29 tsunam Exp $

inherit autotools

DESCRIPTION="Beryl Window Decorator Themes"
HOMEPAGE="http://beryl-project.org"
SRC_URI="http://distfiles.xgl-coffee.org/${PN}/${P}.tar.bz2"

LICENSE="X11"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="x11-wm/emerald"

S="${WORKDIR}/${PN}"

src_compile() {
	eautoreconf || die "eautoreconf failed"
	glib-gettextize --copy --force || die

	econf || die "econf failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}
