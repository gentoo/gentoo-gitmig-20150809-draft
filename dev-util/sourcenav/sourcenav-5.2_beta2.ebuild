# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/sourcenav/sourcenav-5.2_beta2.ebuild,v 1.6 2006/04/24 02:58:28 nerdboy Exp $

inherit eutils

IUSE="debug"

MY_P="5.2b2"
S=${WORKDIR}/sourcenav-${MY_P}
SB=${WORKDIR}/snbuild
SN="/opt/sourcenav"

DESCRIPTION="Source-Navigator is a source code analysis and software development tool"
SRC_URI="mirror://sourceforge/sourcenav/sourcenav-${MY_P}.tar.gz"
HOMEPAGE="http://sourcenav.sourceforge.net"

SLOT="0"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"

RDEPEND="|| (
	    ( x11-libs/libXmu
	    x11-libs/libXext
	    x11-libs/libXp
	    x11-libs/libX11
	    x11-libs/libXt
	    x11-libs/libSM
	    x11-libs/libICE
	    x11-libs/libXpm
	    x11-libs/libXaw )
	virtual/x11
	)"
DEPEND="${RDEPEND}
	|| (
	    ( x11-proto/xproto x11-proto/xextproto )
	        virtual/x11
	)"

src_unpack() {
	unpack ${A}
#	mkdir ${SB} || die "mkdir build failed"
	cd ${S}
	epatch ${FILESDIR}/sourcenav_destdir.patch || die "epatch failed"
	sed -i -e "s/relid'/relid/" tcl/unix/configure
	sed -i -e "s/relid'/relid/" tk/unix/configure
}

src_compile() {
	cd ${S}
#	../sourcenav-${MY_P}/configure \
	./configure ${MY_CONF} \
		--host=${CHOST} \
		--prefix=${SN} \
		--bindir=${SN}/bin \
		--sbindir=${SN}/sbin \
		--exec-prefix=${SN} \
		--mandir=${SN}/share/man \
		--infodir=${SN}/share/info \
		--datadir=${SN}/share \
		$(use_enable debug symbols) || die "configure failed"

	make all || die "make failed"
}

src_install() {
	cd ${SB}
	make DESTDIR=${D} install || die "install failed"

	chmod -Rf 755 ${D}/${SN}/share/doc/${P}/demos
	dodir /etc/env.d
	echo "PATH=${SN}/bin" > ${D}/etc/env.d/10snavigator
}
