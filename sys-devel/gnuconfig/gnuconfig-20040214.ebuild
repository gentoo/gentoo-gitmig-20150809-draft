# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gnuconfig/gnuconfig-20040214.ebuild,v 1.13 2004/10/23 05:44:56 mr_bones_ Exp $

inherit eutils

DESCRIPTION="Updated config.sub and config.guess file from GNU"
HOMEPAGE="ftp://ftp.gnu.org/pub/gnu/config"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ppc64 sparc mips alpha arm hppa amd64 ~ia64 ppc-macos"
IUSE="uclibc"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PN}-20040312-update.patch
	use uclibc && epatch ${FILESDIR}/automake-1.8.5-config-guess-uclibc.patch
}

src_install() {
	insinto /usr/share/${PN}
	doins ${WORKDIR}/ChangeLog ${WORKDIR}/config.sub ${WORKDIR}/config.guess || die
	chmod +x ${D}/usr/share/${PN}/config.sub
	chmod +x ${D}/usr/share/${PN}/config.guess
}
