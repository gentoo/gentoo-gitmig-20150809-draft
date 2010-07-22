# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libpciaccess/libpciaccess-0.11.0.ebuild,v 1.6 2010/07/22 16:19:59 maekke Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="Library providing generic access to the PCI bus and devices"

KEYWORDS="~alpha amd64 arm hppa ~ia64 ~mips ppc ppc64 ~sh ~sparc x86 ~x86-fbsd"
IUSE="minimal zlib"

DEPEND="zlib? ( sys-libs/zlib )"
RDEPEND="${DEPEND}"

pkg_setup() {
	CONFIGURE_OPTIONS="$(use_with zlib)
		--with-pciids-path=/usr/share/misc"
}

src_install() {
	x-modular_src_install
	if ! use minimal; then
		dobin src/.libs/scanpci || die
	fi
}
