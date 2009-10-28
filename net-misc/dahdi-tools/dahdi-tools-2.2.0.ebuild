# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dahdi-tools/dahdi-tools-2.2.0.ebuild,v 1.1 2009/10/28 11:25:13 chainsaw Exp $

EAPI=1
inherit eutils

DESCRIPTION="Userspace tools to configure the kernel modules from net-misc/dahdi"
HOMEPAGE="http://www.asterisk.org"
SRC_URI="http://downloads.digium.com/pub/telephony/dahdi-tools/releases/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-misc/dahdi
	virtual/libusb:0"

RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-ifreq.patch"
	epatch "${FILESDIR}/${P}-modprobe-suffix.patch"
}

src_install() {
	emake DESTDIR="${D}" install || die "Failed to install binaries"
	emake DESTDIR="${D}" config || die "Failed to install configuration files"

	# install init script
	newinitd "${FILESDIR}"/dahdi.init2 dahdi
}
