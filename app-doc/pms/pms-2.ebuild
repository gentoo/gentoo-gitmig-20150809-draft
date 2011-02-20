# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/pms/pms-2.ebuild,v 1.6 2011/02/20 16:19:17 xarthisius Exp $

EAPI=2

DESCRIPTION="Gentoo Package Manager Specification (draft)"
HOMEPAGE="http://www.gentoo.org/proj/en/qa/pms.xml"
SRC_URI="http://dev.gentoo.org/~gentoofan23/pms/eapi-2-approved/pms.pdf -> pms-${PV}.pdf"

LICENSE="CCPL-Attribution-ShareAlike-3.0"
SLOT="2"
KEYWORDS="alpha amd64 ~amd64-fbsd arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd ~ppc-aix ~x86-freebsd ~x64-freebsd ~hppa-hpux ~ia64-hpux ~x86-interix ~mips-irix ~amd64-linux ~arm-linux ~ia64-linux ~x86-linux ~ppc-macos ~x86-macos ~x64-macos ~m68k-mint ~x86-netbsd ~ppc-openbsd ~x86-openbsd ~x64-openbsd ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris ~x86-winnt"
IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {
	:
}

src_install() {
	dodoc "${DISTDIR}"/pms-2.pdf || die
}
