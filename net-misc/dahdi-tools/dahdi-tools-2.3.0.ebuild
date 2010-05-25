# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dahdi-tools/dahdi-tools-2.3.0.ebuild,v 1.1 2010/05/25 15:22:37 chainsaw Exp $

EAPI=3

inherit base

DESCRIPTION="Userspace tools to configure the kernel modules from net-misc/dahdi"
HOMEPAGE="http://www.asterisk.org"
SRC_URI="http://downloads.digium.com/pub/telephony/dahdi-tools/releases/${P}.tar.gz
	mirror://gentoo/gentoo-dahdi-tools-patchset-0.1.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/newt
	net-misc/dahdi
	!net-misc/zaptel
	>=sys-kernel/linux-headers-2.6.29
	virtual/libusb:0"
RDEPEND="${DEPEND}"

EPATCH_SUFFIX="diff"
PATCHES=( "${WORKDIR}/dahdi-tools-patchset" )

src_install() {
	emake DESTDIR="${D}" install || die "Failed to install binaries"
	emake DESTDIR="${D}" config || die "Failed to install configuration files"

	# install init script
	newinitd "${FILESDIR}"/dahdi.init2 dahdi
}
