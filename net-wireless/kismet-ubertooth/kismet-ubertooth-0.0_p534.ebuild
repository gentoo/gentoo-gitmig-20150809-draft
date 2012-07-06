# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/kismet-ubertooth/kismet-ubertooth-0.0_p534.ebuild,v 1.2 2012/07/06 21:12:10 zerochaos Exp $

EAPI="4"

inherit multilib

DESCRIPTION="Provides basic bluetooth support in kismet"
HOMEPAGE="http://ubertooth.sourceforge.net/"

if [[ ${PV} == "9999" ]] ; then
	ESVN_REPO_URI="https://ubertooth.svn.sourceforge.net/svnroot/ubertooth/trunk/host"
	SRC_URI=""
	inherit subversion
	KEYWORDS=""
else
	MY_PV="${PV/p/r}"
	MY_PV="${MY_PV/0.0_/}"
	SRC_URI="mirror://sourceforge/ubertooth/ubertooth-${MY_PV}.tar.gz"
	KEYWORDS="~amd64 ~arm ~x86"
	S="${WORKDIR}/ubertooth-${MY_PV}/host/"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=">=net-wireless/kismet-2011.03.2-r1 \
		>=net-libs/libbtbb-0.8 \
		>=dev-libs/libusb-1.0.0"
RDEPEND="${DEPEND}"

src_compile() {
	if has_version =net-wireless/kismet-9999; then
		cd "${S}/kismet/plugin-ubertooth-phyneutral" || die
	else
		cd "${S}/kismet/plugin-ubertooth" || die
	fi
	emake KIS_SRC_DIR="/usr/include/kismet/"
}

src_install() {
	if has_version =net-wireless/kismet-9999; then
		cd "${S}/kismet/plugin-ubertooth-phyneutral" || die
	else
		cd "${S}/kismet/plugin-ubertooth" || die
	fi
	emake DESTDIR="${ED}" LIBDIR="/usr/$(get_libdir)" KIS_SRC_DIR="/usr/include/kismet/" KIS_DEST_DIR="${D}/usr/" install
}

pkg_postinst() {
	ewarn "This package must be rebuilt every time kismet is rebuilt. Or else."
}
