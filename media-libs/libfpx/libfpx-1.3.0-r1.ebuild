# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libfpx/libfpx-1.3.0-r1.ebuild,v 1.10 2012/05/09 17:34:33 aballier Exp $

EAPI=2
inherit eutils flag-o-matic libtool

DESCRIPTION="A library for manipulating FlashPIX images"
HOMEPAGE="http://www.i3a.org/"
SRC_URI="mirror://imagemagick/delegates/${P}-1.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-solaris"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.2.0.13-export-symbols.patch
	# we're not windows, even though we don't define __unix by default
	[[ ${CHOST} == *-darwin* ]] && append-flags -D__unix
	elibtoolize
}

src_configure() {
	append-ldflags -Wl,--no-undefined
	econf \
		--disable-dependency-tracking \
		LIBS="-lstdc++ -lm"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog doc/*.txt || die "dodoc failed"
	insinto /usr/share/doc/${PF}/pdf
	doins doc/*.pdf || die "doins failed"
}
