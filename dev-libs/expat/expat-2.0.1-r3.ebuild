# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/expat/expat-2.0.1-r3.ebuild,v 1.9 2011/07/11 19:52:51 aballier Exp $

inherit eutils libtool toolchain-funcs

DESCRIPTION="XML parsing libraries"
HOMEPAGE="http://expat.sourceforge.net/"
SRC_URI="mirror://sourceforge/expat/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd"
IUSE="elibc_FreeBSD"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# fix segmentation fault in python tests (bug #197043)
	epatch "${FILESDIR}/${P}-check_stopped_parser.patch"

	epatch "${FILESDIR}"/${P}-fix_bug_1990430.patch \
		"${FILESDIR}"/${P}-CVE-2009-3560-revised.patch

	elibtoolize
	epunt_cxx
}

src_install() {
	emake install DESTDIR="${D}" || die
	# libgeom in /lib and ifconfig in /sbin require it on FreeBSD since we
	# stripped the libbsdxml copy starting from freebsd-lib-8.2-r1
	use elibc_FreeBSD && gen_usr_ldscript -a expat
	dodoc Changes README || die
	dohtml doc/* || die
}
