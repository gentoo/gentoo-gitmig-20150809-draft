# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/electricsheep/electricsheep-2.4.ebuild,v 1.2 2003/09/06 11:54:14 lanius Exp $

inherit eutils

DESCRIPTION="realize the collective dream of sleeping computers from all over the internet"
HOMEPAGE="http://electricsheep.org/"
SRC_URI="http://electricsheep.org/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"

DEPEND="virtual/x11
	dev-libs/expat
	sys-apps/groff
	dev-lang/perl
	>=sys-apps/sed-4
	media-libs/libmpeg2"
RDEPEND="virtual/x11
	dev-libs/expat
	net-ftp/curl
	x11-misc/xloadimage"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i \
		-e "s:/usr/local/share:/usr/share/${PN}:" electricsheep.c || \
			die "sed electricsheep.c failed"
}

src_install() {
	# prevent writing for xscreensaver
	sed -i \
		-e "s/^install-data-local:$/install-data-local:\nmy-install-data-local:/" \
		Makefile || die "sed Makefile failed"

	# install the main stuff ... flame doesn't create /usr/bin so we have to.
	dodir /usr/bin
	make install DESTDIR=${D} || die "make install failed"

	# remove header files that are installed over libmpeg2
	rm -rf ${D}/usr/include

	# install the xscreensaver config file
	insinto /usr/share/control-center/screensavers
	doins electricsheep.xml
}
