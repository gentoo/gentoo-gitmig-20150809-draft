# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/electricsheep/electricsheep-2.4-r2.ebuild,v 1.4 2004/03/29 03:53:45 vapier Exp $

inherit eutils

DESCRIPTION="realize the collective dream of sleeping computers from all over the internet"
HOMEPAGE="http://electricsheep.org/"
SRC_URI="http://electricsheep.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc"

DEPEND="virtual/x11
	dev-libs/expat
	sys-apps/groff
	dev-lang/perl
	>=sys-apps/sed-4
	media-libs/libmpeg2"
RDEPEND="virtual/x11
	dev-libs/expat
	net-misc/curl
	media-gfx/xloadimage"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s:/usr/local/share:/usr/share/${PN}:" \
		electricsheep.c \
		|| die "sed electricsheep.c failed"
	sed -i '/OPT_CFLAGS=/s:=".*":="$CFLAGS":' \
		mpeg2dec/configure \
		|| die "sed mpeg2dec failed"
	epatch ${FILESDIR}/nice.patch
}

src_install() {
	# prevent writing for xscreensaver
	sed -i "s/^install-data-local:$/install-data-local:\nmy-install-data-local:/" \
		Makefile || die "sed Makefile failed"

	# install the xscreensaver config file
	insinto /usr/share/control-center/screensavers
	doins electricsheep.xml

	# install the main stuff ... flame doesn't create /usr/bin so we have to.
	dodir /usr/bin
	make install DESTDIR=${D} || die "make install failed"
	dodir /usr/share/electricsheep
	mv ${D}/usr/share/electricsheep-* ${D}/usr/share/electricsheep/

	# remove header files that are installed over libmpeg2
	rm -rf ${D}/usr/include
}
