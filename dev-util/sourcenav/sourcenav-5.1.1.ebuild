# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/sourcenav/sourcenav-5.1.1.ebuild,v 1.12 2005/11/26 06:04:50 nerdboy Exp $

inherit eutils libtool toolchain-funcs

S=${WORKDIR}/build

DESCRIPTION="Source-Navigator is an IDE, as well as a source code analysis and reverse-engineering tool."
SRC_URI="mirror://sourceforge/sourcenav/${P}.tar.gz"
HOMEPAGE="http://sourcenav.sourceforge.net"

SLOT="0"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="x86 ~sparc ~ppc"
IUSE=""
DEPEND=">=sys-libs/glibc-2.2.4"
SN="/usr/snavigator"

src_unpack() {
	mkdir build
	unpack ${A}

	cd ${WORKDIR}/${P}
	export WANT_AUTOMAKE=1.5
	export WANT_AUTOCONF=2.13
	epatch ${FILESDIR}/${PF}-gentoo.diff|| die "epatch failed"
	sed -i -e "s/PICFLAG =/PICFLAG = -fPIC/" Makefile.in
	cd ${S}
	../${P}/snavigator/autogen.sh
}

src_compile() {
	../${P}/configure \
		--host=${CHOST} \
		--prefix=${SN} \
		--exec-prefix=${SN} \
		--bindir=${SN}/bin \
		--sbindir=${SN}/sbin \
		--mandir=${SN}/share/man \
		--infodir=${SN}/share/info \
		--datadir=${SN}/share || die "configure failed"

	make || die "make failed"
}

src_install() {
	make DESTDIR=${D} \
		install-snavigator || die

	chmod -Rf 755 ${D}/usr/share/doc/${P}/demos
	dodir /etc/env.d
	echo "PATH=/usr/snavigator/bin" > ${D}/etc/env.d/10snavigator
}
