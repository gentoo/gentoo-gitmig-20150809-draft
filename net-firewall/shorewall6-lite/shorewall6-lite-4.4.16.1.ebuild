# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/shorewall6-lite/shorewall6-lite-4.4.16.1.ebuild,v 1.1 2011/01/23 19:24:26 constanze Exp $

inherit versionator linux-info

# Select version (stable, RC, Beta):
MY_PV_TREE=$(get_version_component_range 1-2)   # for devel versions use "development/$(get_version_component_range 1-2)"
MY_P_BETA=""                                    # stable or experimental (eg. "-RC1" or "-Beta4")
MY_PV_BASE=$(get_version_component_range 1-3)

MY_PN="${PN/6-lite/}"
MY_P="${MY_PN}-${MY_PV_BASE}${MY_P_BETA}"
MY_P_DOCS="${MY_PN}-docs-html-${PV}${MY_P_BETA}"

DESCRIPTION="An iptables-based firewall whose config is handled by a normal Shorewall6."
HOMEPAGE="http://www.shorewall.net/"
SRC_URI="http://www1.shorewall.net/pub/${MY_PN}/${MY_PV_TREE}/${MY_P}/${P}${MY_P_BETA}.tar.bz2
	doc? ( http://www1.shorewall.net/pub/${MY_PN}/${MY_PV_TREE}/${MY_P}/${MY_P_DOCS}.tar.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~sparc ~x86"
IUSE="doc"

DEPEND=">=net-firewall/iptables-1.4.0
	sys-apps/iproute2"
RDEPEND="${DEPEND}"

pkg_setup() {
	if kernel_is lt 2 6 25 ; then
		die "${PN} requires at least kernel 2.6.25."
	fi
}

src_compile() {
	:;
}

src_install() {
	keepdir /var/lib/${PN}

	cd "${WORKDIR}/${P}${MY_P_BETA}"
	PREFIX="${D}" ./install.sh || die "install.sh failed"
	newinitd "${FILESDIR}"/${PN}.initd ${PN} || die

	dodoc changelog.txt releasenotes.txt
}
