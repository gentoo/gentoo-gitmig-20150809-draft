# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/linuxfromscratch-pdf/linuxfromscratch-pdf-6.2.ebuild,v 1.1 2006/08/17 04:39:23 wormo Exp $

MY_P="LFS-BOOK-${PV}.pdf"
DESCRIPTION="The Linux From Scratch Book"
HOMEPAGE="http://www.linuxfromscratch.org/"
SRC_URI="http://www.linuxfromscratch.org/lfs/downloads/${PV}/${MY_P}"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE=""

S=${WORKDIR}

src_unpack() {
	cp ${DISTDIR}/${MY_P} ${S}
}

src_install() {
	insinto /usr/share/doc/linuxfromscratch-${PV}
	doins -r * || die "doins failed"
}
