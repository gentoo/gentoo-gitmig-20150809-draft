# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/cheops-ng/cheops-ng-0.1.13-r1.ebuild,v 1.1 2005/04/02 22:06:01 vanquirius Exp $

inherit eutils

DESCRIPTION="Cheops-ng is a Network management tool for mapping and monitoring your network"
HOMEPAGE="http://cheops-ng.sourceforge.net/"
SRC_URI="mirror://sourceforge/cheops-ng/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="debug"
DEPEND=">=net-analyzer/nmap-3.27-r1
	=x11-libs/gtk+-1.2*
	>=dev-libs/libxml-1.8.17-r2
	>=gnome-base/gnome-libs-1.4.2
	>=media-libs/imlib-1.9.14-r1
	>=dev-libs/glib-1.2.10-r5
	media-libs/libpng"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-printf.diff
	cd adns-1.0
	epatch ${FILESDIR}/adns-gcc34.patch
}

src_compile() {
	# disable/enable debug
	if use debug; then
		sed -i -e 's/^\/\/#define DEBUG/#define DEBUG/g' ./*.c || die "sed failed"
		sed -i -e 's/^\/\/#define DEBUG/#define DEBUG/g' ./*.h || die "sed failed"

	else
	# we need to disable the noisy nmap debug and any other
		sed -i -e 's/^#define DEBUG/\/\/#define DEBUG/g' ./*.c || die "sed failed"
		sed -i -e 's/^#define DEBUG/\/\/#define DEBUG/g' ./*.h || die "sed failed"
	fi

	# First we need to configure adns
	cd adns-1.0
	econf || die
	cd ..
	# Now we configure cheops-ng
	econf || die

	# Fix for the gpl.c file that adds \ at the end of COPYING puts the result
	# in toto and change the reference to the file in Makefile.
	sed \
		-e 's/$/ \\/g' \
		-e 's/"/""/g' \
		COPYING > toto || die "sed failed"
	sed -i \
		-e '146s/\\""/\\"\\\\"/g' \
		-e 's/COPYING/toto/g' \
		Makefile || die "sed failed"
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS COPYING README NEWS ReleaseNotes doc/*.txt
}
