# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libpciaccess/libpciaccess-0.12.0.ebuild,v 1.7 2010/12/31 20:13:27 jer Exp $

EAPI=3

inherit xorg-2

DESCRIPTION="Library providing generic access to the PCI bus and devices"
KEYWORDS="~alpha amd64 arm hppa ~ia64 ~mips ~ppc ppc64 ~sh ~sparc x86 ~x86-fbsd"
IUSE="minimal zlib"

DEPEND="zlib? ( sys-libs/zlib )"
RDEPEND="${DEPEND}"

pkg_setup() {
	xorg-2_pkg_setup

	CONFIGURE_OPTIONS="$(use_with zlib)
		--with-pciids-path=/usr/share/misc"
}

src_install() {
	xorg-2_src_install
	use minimal || { dobin src/.libs/scanpci || die ; }
}
