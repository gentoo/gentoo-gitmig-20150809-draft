# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gnuconfig/gnuconfig-20040214.ebuild,v 1.2 2004/02/19 22:31:48 tgall Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Updated config.sub and config.guess file from GNU"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
HOMEPAGE="ftp://ftp.gnu.org/pub/gnu/config"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~mips ~sparc ~x86 ~ppc ~alpha ~hppa ~amd64 ~ia64 ppc64"

src_install() {
	insinto /usr/share/${PN}
	doins ${WORKDIR}/ChangeLog ${WORKDIR}/config.sub ${WORKDIR}/config.guess
	chmod +x ${D}/usr/share/${PN}/config.sub
	chmod +x ${D}/usr/share/${PN}/config.guess
}
