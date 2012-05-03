# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/pal/pal-0.3.4-r1.ebuild,v 1.5 2012/05/03 19:41:34 jdhore Exp $

inherit toolchain-funcs eutils

DESCRIPTION="pal command-line calendar program"
HOMEPAGE="http://palcal.sourceforge.net/"
SRC_URI="mirror://sourceforge/palcal/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="nls"

RDEPEND=">=dev-libs/glib-2.0
	sys-libs/readline
	sys-libs/ncurses
	nls? ( virtual/libintl )"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

S="${WORKDIR}/${P}/src"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PV}-strip.patch
	epatch "${FILESDIR}"/${PV}-ldflags.patch
}

src_compile() {
	emake CC="$(tc-getCC)" OPT="${CFLAGS}" LDOPT="${LDFLAGS}" \
		|| die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install-man install-bin install-share \
		|| die "make install failed"

	if use nls; then
		make DESTDIR="${D}" install-mo || die "make install-mo failed"
	fi

	dodoc "${WORKDIR}"/${P}/{ChangeLog,doc/example.css} || die "dodoc failed"
}
