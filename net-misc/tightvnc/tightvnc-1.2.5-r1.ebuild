# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/tightvnc/tightvnc-1.2.5-r1.ebuild,v 1.5 2002/09/21 12:09:35 bjb Exp $

S="${WORKDIR}/vnc_unixsrc"
DESCRIPTION="A great client/server software package allowing remote network access to graphical desktops."
SRC_URI="mirror://sourceforge/vnc-tight/${P}_unixsrc.tar.bz2"
HOMEPAGE="http://www.tightvnc.com"
KEYWORDS="x86 alpha"
LICENSE="GPL-2"
SLOT="0"
DEPEND="virtual/x11
	sys-devel/perl
	~media-libs/jpeg-6b
	sys-libs/zlib"

RDEPEND=$DEPEND

src_unpack() {
	unpack ${A} ; cd ${S}
	#patch <${FILESDIR}/tightvnc-gentoo.diff || die

	# fix #6814
	cp vncserver vncserver.orig
	sed -e 's%^if (!xauthorityFile) {%if (!\$xauthorityFile) {%' \
		vncserver.orig > vncserver
}

src_compile() {

	cd ${S}
	xmkmf || die
	make World || die
	cd Xvnc
	./configure || die
	make || die

}

src_install() {

	cd ${S}
	mkdir -p ${D}/usr/man
	mkdir -p ${D}/usr/man/man1
	mkdir -p ${D}/usr/bin

	# fix the web based interface, it needs the java class files
	mkdir -p ${D}/usr/share/tightvnc
	mkdir -p ${D}/usr/share/tightvnc/classes
	insinto /usr/share/tightvnc/classes ; doins classes/*

	# and then patch vncserver to point to /usr/share/tightvnc/classes
	patch -p0 < ${FILESDIR}/tightvnc-gentoo.diff || die

	./vncinstall ${D}/usr/bin ${D}/usr/man || die
}
