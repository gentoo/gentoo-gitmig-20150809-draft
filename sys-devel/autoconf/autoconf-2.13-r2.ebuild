# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/autoconf/autoconf-2.13-r2.ebuild,v 1.15 2003/09/06 08:10:52 msterret Exp $

IUSE=""

S="${WORKDIR}/${P}"
DESCRIPTION="Used to create autoconfiguration files"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/autoconf/autoconf.html"

LICENSE="GPL-2"
KEYWORDS="x86 sparc"
SLOT="2"

DEPEND="~sys-devel/m4-1.4"

src_unpack() {

	unpack ${A}
	cd ${S}
	patch -p0 < ${FILESDIR}/${P}-configure-gentoo.diff || die
	patch -p0 < ${FILESDIR}/${P}-configure.in-gentoo.diff || die
}

src_compile() {

	./configure --prefix=/usr \
		--infodir=/usr/share/info \
		--host=${CHOST} || die

	make ${MAKEOPTS} || die
}

src_install() {

	make prefix=${D}/usr \
		infodir=${D}/usr/share/info \
		install || die

	exeinto /usr/share/autoconf
	doexe ${S}/install-sh

	dodoc COPYING AUTHORS ChangeLog.* NEWS README TODO
}

