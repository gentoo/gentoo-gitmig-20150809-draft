# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/sourcenav/sourcenav-5.1.4.ebuild,v 1.2 2003/09/06 08:39:23 msterret Exp $

S=${WORKDIR}/build

DESCRIPTION="Source-Navigator is a source code analysis tool"
SRC_URI="mirror://sourceforge/sourcenav/${P}.tar.gz"
HOMEPAGE="http://sourcenav.sourceforge.net"

SLOT="0"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="~x86 ~sparc  ~ppc"
IUSE="X"
DEPEND=">=sys-libs/glibc-2.2.4"
SN="/opt/sourcenav"

src_unpack() {
	unpack ${A}
	mkdir ${WORKDIR}/build
	cd ${WORKDIR}/${P}

	patch -p0 < ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {
	cd ${WORKDIR}/build
	../${P}/configure \
		--host=${CHOST} \
		--prefix=${SN} \
		--mandir=${SN}/share/man \
		--infodir=${SN}/share/info \
		--datadir=${SN}/share || die

	make || die
}

src_install() {
	make DESTDIR=${D} install || die

	chmod -Rf 755 ${D}/${SN}/share/doc/${P}/demos
	dodir /etc/env.d
	echo "PATH=${SN}/bin" > ${D}/etc/env.d/10snavigator
}
