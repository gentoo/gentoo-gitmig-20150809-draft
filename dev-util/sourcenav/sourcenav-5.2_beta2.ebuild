# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/sourcenav/sourcenav-5.2_beta2.ebuild,v 1.3 2004/11/12 17:44:05 blubb Exp $

inherit eutils

IUSE=""

MY_P="5.2b2"
S=${WORKDIR}/sourcenav-${MY_P}
SB=${WORKDIR}/build
SN="/opt/sourcenav"

DESCRIPTION="Source-Navigator is a source code analysis and software development tool"
SRC_URI="mirror://sourceforge/sourcenav/sourcenav-${MY_P}.tar.gz"
HOMEPAGE="http://sourcenav.sourceforge.net"

SLOT="0"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"

RDEPEND="virtual/x11"
DEPEND=">=sys-libs/glibc-2.2.4
	${RDEPEND}"

src_unpack() {
	unpack ${A}
	mkdir ${SB} || die "mkdir build failed"
	cd ${S}
	epatch ${FILESDIR}/sourcenav_destdir.patch || die "epatch failed"
}

src_compile() {
	cd ${SB}
	../sourcenav-${MY_P}/configure \
		--host=${CHOST} \
		--prefix=${SN} \
		--mandir=${SN}/share/man \
		--infodir=${SN}/share/info \
		--datadir=${SN}/share || die "configure failed"

	make || die "make failed"
}

src_install() {
	cd ${SB}
	make DESTDIR=${D} install || die "install failed"

	chmod -Rf 755 ${D}/${SN}/share/doc/${P}/demos
	dodir /etc/env.d
	echo "PATH=${SN}/bin" > ${D}/etc/env.d/10snavigator
}
