# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/electricsheep/electricsheep-2.3_beta11.ebuild,v 1.2 2003/02/13 17:12:18 vapier Exp $

inherit eutils

MY_P="${PN}-${PV/_beta/b}"
DESCRIPTION="realize the collective dream of sleeping computers from all over the internet"
HOMEPAGE="http://electricsheep.org/"
SRC_URI="http://electricsheep.org/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/x11
	sys-apps/groff
	sys-devel/perl
	media-libs/libmpeg2"
RDEPEND="virtual/x11
	net-ftp/curl
	x11-misc/xloadimage"

S="${WORKDIR}/${MY_P}"

src_compile() {
	epatch ${FILESDIR}/${P}-paths.patch
	autoconf || die
	econf --datadir=/usr/share/${PN} || die
	emake || die
}

src_install() {
	# prevent writing for xscreensaver
	cp Makefile Makefile.old
	sed -e "s/^install-data-local:$/install-data-local:\nmy-install-data-local:/" \
		Makefile.old > Makefile

	# install the main stuff ... flame doesnt create /usr/bin so we have to
	dodir /usr/bin
	make install DESTDIR=${D} || die

	# remove header files that are installed over libmpeg2
	rm -rf ${D}/usr/include

	# install the xscreensaver config file
	insinto /usr/share/control-center/screensavers
	doins electricsheep.xml
}
