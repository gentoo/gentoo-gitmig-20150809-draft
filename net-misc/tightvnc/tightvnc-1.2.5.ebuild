# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $ Header: $

S="${WORKDIR}/vnc_unixsrc"
DESCRIPTION="A great client/server software package allowing remote network access to graphical desktops."
SRC_URI="mirror://sourceforge/vnc-tight/${P}_unixsrc.tar.bz2"
HOMEPAGE="http://www.tightvnc.com"
KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"
DEPEND="virtual/glibc
	>=x11-base/xfree-4.1.0
	>=sys-devel/perl-5.6.1
	~media-libs/jpeg-6b
	>=sys-libs/zlib-1.1.4"

RDEPEND=$DEPEND

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
