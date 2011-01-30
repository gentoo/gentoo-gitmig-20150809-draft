# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gcal/gcal-3.6.ebuild,v 1.6 2011/01/30 18:36:56 armin76 Exp $

EAPI="3"

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="The GNU Calendar - a replacement for cal"
HOMEPAGE="http://www.gnu.org/software/gcal/"
SRC_URI="mirror://gnu/gcal/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="alpha amd64 ~arm ppc sparc x86"
IUSE="ncurses nls"

DEPEND="nls? ( >=sys-devel/gettext-0.17 )"
RDEPEND=""

src_configure() {
	tc-export CC
	append-flags -D_GNU_SOURCE
	econf \
		--disable-rpath \
		$(use_enable nls) \
		$(use_enable ncurses term)
}

src_install() {
	emake DESTDIR="${ED}" install || die

	dodoc BUGS LIMITATIONS NEWS README THANKS TODO || die
}
