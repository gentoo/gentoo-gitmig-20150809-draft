# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gnuconfig/gnuconfig-20040214.ebuild,v 1.7 2004/06/11 18:18:54 kloeri Exp $

DESCRIPTION="Updated config.sub and config.guess file from GNU"
HOMEPAGE="ftp://ftp.gnu.org/pub/gnu/config"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ppc64 sparc mips alpha arm hppa amd64 ~ia64"
IUSE=""

src_install() {
	insinto /usr/share/${PN}
	doins ${WORKDIR}/ChangeLog ${WORKDIR}/config.sub ${WORKDIR}/config.guess || die
	chmod +x ${D}/usr/share/${PN}/config.sub
	chmod +x ${D}/usr/share/${PN}/config.guess
}
