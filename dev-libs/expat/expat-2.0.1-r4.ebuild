# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/expat/expat-2.0.1-r4.ebuild,v 1.1 2011/07/29 16:33:13 ssuominen Exp $

EAPI=2
inherit eutils libtool toolchain-funcs

DESCRIPTION="XML parsing libraries"
HOMEPAGE="http://expat.sourceforge.net/"
SRC_URI="mirror://sourceforge/expat/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE="elibc_FreeBSD static-libs"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-check_stopped_parser.patch \
		"${FILESDIR}"/${P}-fix_bug_1990430.patch \
		"${FILESDIR}"/${P}-CVE-2009-3560-revised.patch

	elibtoolize
	epunt_cxx
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install || die

	use static-libs || rm -f "${D}"usr/lib*/libexpat.la

	# libgeom in /lib and ifconfig in /sbin require it on FreeBSD since we
	# stripped the libbsdxml copy starting from freebsd-lib-8.2-r1
	use elibc_FreeBSD && gen_usr_ldscript -a expat

	dodoc Changes README || die
	dohtml doc/* || die
}
