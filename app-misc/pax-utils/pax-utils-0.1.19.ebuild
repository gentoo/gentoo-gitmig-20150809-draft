# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/pax-utils/pax-utils-0.1.19.ebuild,v 1.9 2009/01/05 20:44:40 yoswink Exp $

inherit flag-o-matic toolchain-funcs eutils

DESCRIPTION="ELF related utils for ELF 32/64 binaries that can check files for security relevant properties"
HOMEPAGE="http://hardened.gentoo.org/pax-utils.xml"
SRC_URI="mirror://gentoo/pax-utils-${PV}.tar.bz2
	http://dev.gentoo.org/~solar/pax/pax-utils-${PV}.tar.bz2
	http://dev.gentoo.org/~vapier/dist/pax-utils-${PV}.tar.bz2"
#SRC_URI="http://wh0rd.org/pax-utils-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc -sparc-fbsd x86 -x86-fbsd"
IUSE="caps"
#RESTRICT="mirror"

DEPEND="caps? ( sys-libs/libcap )"

src_compile() {
	emake CC="$(tc-getCC)" USE_CAP=$(use caps && echo yes) || die
}

src_install() {
	emake DESTDIR="${D}" install || die
}
