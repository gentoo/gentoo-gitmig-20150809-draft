# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/mDNSResponder/mDNSResponder-98.ebuild,v 1.9 2005/06/22 14:00:02 greg_g Exp $

inherit eutils

DESCRIPTION="The mDNSResponder project is a component of Bonjour, Apple's initiative for zero-configuration networking."
HOMEPAGE="http://developer.apple.com/networking/bonjour/index.html"
SRC_URI="http://helios.et.put.poznan.pl/~jstachow/pub/${P}.tar.gz"
LICENSE="APSL-2"

SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ppc64 ~sparc x86"
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
