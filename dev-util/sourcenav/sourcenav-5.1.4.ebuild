# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/sourcenav/sourcenav-5.1.4.ebuild,v 1.10 2006/07/20 04:58:45 nerdboy Exp $

inherit eutils libtool toolchain-funcs flag-o-matic

S=${WORKDIR}/build

DESCRIPTION="Source-Navigator is a source code analysis tool"
SRC_URI="mirror://sourceforge/sourcenav/${P}.tar.gz
mirror://gentoo/${P}-gentoo.diff.gz"
HOMEPAGE="http://sourcenav.sourceforge.net"

SLOT="0"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="amd64 sparc ppc ppc64 x86"
IUSE=""
SN="/opt/sourcenav"

RDEPEND="|| (
	  ( x11-libs/libX11
	    x11-libs/libXdmcp
	    x11-libs/libXaw )
	virtual/x11
	)
	sys-libs/glibc"

DEPEND="${RDEPEND}
	|| (
	 ( x11-proto/xproto )
	virtual/x11
	)"

src_unpack() {
	unpack ${A}
	mkdir ${WORKDIR}/build
	cd ${WORKDIR}/${P}
	epatch ${DISTDIR}/${PF}-gentoo.diff.gz || die "big patch failed"
	epatch ${FILESDIR}/${P}-bash3.patch || die "bash3 patch failed"
	# Backported from 5.2
	if [ $(gcc-major-version) -ge 4 ]; then
	    epatch ${FILESDIR}/${P}-gcc4.patch || die "gcc4 patch failed"
	fi
}

src_compile() {
	cd ${WORKDIR}/build
	../${P}/configure \
		--host=${CHOST} \
		--prefix=${SN} \
		--exec-prefix=${SN} \
		--bindir=${SN}/bin \
		--sbindir=${SN}/sbin \
		--mandir=${SN}/share/man \
		--infodir=${SN}/share/info \
		--datadir=${SN}/share \
		--libdir=${SN}/$(get_libdir) || die "configure failed"

	make || die
}

src_install() {
	make DESTDIR=${D} install || die

	chmod -Rf 755 ${D}/${SN}/share/doc/${P}/demos
	dodir /etc/env.d
	echo "PATH=${SN}/bin" > ${D}/etc/env.d/10snavigator
}
