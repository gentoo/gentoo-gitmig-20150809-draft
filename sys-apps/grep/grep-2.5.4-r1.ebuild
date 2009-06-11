# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/grep/grep-2.5.4-r1.ebuild,v 1.6 2009/06/11 20:43:22 maekke Exp $

EAPI=2

inherit eutils

DESCRIPTION="GNU regular expression matcher"
HOMEPAGE="http://www.gnu.org/software/grep/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.bz2
	mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ~ppc ~ppc64 s390 sh sparc x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd"
IUSE="nls pcre"

RDEPEND="nls? ( virtual/libintl )
	pcre? ( >=dev-libs/libpcre-7.8-r1 )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2.5.3-po-builddir-fix.patch
	epatch "${FILESDIR}"/${PN}-2.5.3-nls.patch
}

src_configure() {
	econf \
		--bindir=/bin \
		$(use_enable nls) \
		$(use_enable pcre perl-regexp) \
		$(use elibc_FreeBSD || echo --without-included-regex) \
		|| die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
}
