# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/mDNSResponder/mDNSResponder-98.ebuild,v 1.16 2005/08/25 00:12:48 agriffis Exp $

inherit eutils

DESCRIPTION="The mDNSResponder project is a component of Bonjour, Apple's initiative for zero-configuration networking."
HOMEPAGE="http://developer.apple.com/networking/bonjour/index.html"
SRC_URI="http://helios.et.put.poznan.pl/~jstachow/pub/${P}.tar.gz"
LICENSE="APSL-2"

SLOT="0"
KEYWORDS="~alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE=""

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
