# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/mDNSResponder/mDNSResponder-98.ebuild,v 1.5 2005/03/19 07:02:16 morfic Exp $

inherit eutils

DESCRIPTION="The mDNSResponder project is a component of Rendezvous, Apple's ease-of-use IP networking initiative."
HOMEPAGE="http://developer.apple.com/macosx/rendezvous/"
SRC_URI="http://helios.et.put.poznan.pl/~jstachow/pub/${P}.tar.gz"

LICENSE="APSL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~sparc ~ppc"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-Makefiles.patch
}

src_compile() {
	cd ${S}/mDNSPosix
	make os=linux
}

src_install() {
	cd ${S}/mDNSPosix
	dodir /usr/sbin
	dodir /usr/bin
	dodir /usr/lib
	dodir /usr/include
	dodir /lib/
	dodir /etc/
	dodir /usr/share/man/man5/
	dodir /usr/share/man/man8/

	make DESTDIR=${D} os=linux install

	# Install init scripts
	newinitd ${FILESDIR}/mdnsd.init.d mdnsd
}
