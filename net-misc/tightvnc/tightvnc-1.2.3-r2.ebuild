# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Bart Verwilst <verwilst@gentoo.org>
# Modified by Ivan C.  <navi_@hotmail.com>
# $Header: /var/cvsroot/gentoo-x86/net-misc/tightvnc/tightvnc-1.2.3-r2.ebuild,v 1.10 2003/06/12 21:53:50 msterret Exp $

S="${WORKDIR}/vnc_unixsrc"
DESCRIPTION="A great client/server software package allowing remote network access to graphical desktops."
SRC_URI="mirror://sourceforge/vnc-tight/${P}_unixsrc.tar.bz2"
HOMEPAGE="http://www.tightvnc.com"

KEYWORDS="x86 ppc sparc alpha"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/glibc
	>=x11-base/xfree-4.1.0
	>=dev-lang/perl-5.6.1
	~media-libs/jpeg-6b
	>=sys-libs/zlib-1.1.4"

src_compile() {
	xmkmf || die
	make World || die
	cd Xvnc
	make World || die
}

src_install() {
	dodir /usr/man
	dodir /usr/man/man1
	dodir /usr/bin

	# fix the web based interface, it needs the java class files
	dodir /usr/share/tightvnc
	dodir /usr/share/tightvnc/classes
	insinto /usr/share/tightvnc/classes ; doins classes/*

	# and then patch vncserver to point to /usr/share/tightvnc/classes
	patch -p0 < ${FILESDIR}/tightvnc-gentoo.diff || die

	./vncinstall ${D}/usr/bin ${D}/usr/man || die
}
