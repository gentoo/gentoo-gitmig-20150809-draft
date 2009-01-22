# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/shorewall-perl/shorewall-perl-4.0.15.ebuild,v 1.1 2009/01/22 08:22:05 pva Exp $

inherit versionator

# Select version (stable, RC, Beta, upstream patched):
MY_PV_TREE=$(get_version_component_range 1-2)	# for devel versions use "development/$(get_version_component_range 1-2)"
MY_P_BETA=""      				# stable or experimental (eg. "-RC1" or "-Beta4")
MY_PV_BASE=$(get_version_component_range 1-3)	# which shorewall-common to use

MY_PN="${PN/-perl/}"
MY_P="${MY_PN}-${MY_PV_BASE}${MY_P_BETA}"

DESCRIPTION="Shoreline Firewall Perl-based compiler that allows faster compilation and execution."
HOMEPAGE="http://www.shorewall.net/"
SRC_URI="http://www1.shorewall.net/pub/${MY_PN}/${MY_PV_TREE}/${MY_P}/${P}${MY_P_BETA}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"

IUSE=""

DEPEND="net-firewall/iptables
	sys-apps/iproute2
	dev-lang/perl
	!<net-firewall/shorewall-4.0"

PDEPEND="=net-firewall/shorewall-common-${MY_PV_BASE}*"

src_compile() {
	einfo "Nothing to compile."
}

src_install() {
	cd "${WORKDIR}/${P}${MY_P_BETA}"
	PREFIX="${D}" ./install.sh || die "install.sh failed"

	dodoc releasenotes.txt
}

pkg_postinst() {
	einfo
	einfo "Documentation is available at http://www.shorewall.net"
	einfo
	elog "In order to use the Perl compiler you need to add"
	elog "SHOREWALL_COMPILER=perl"
	elog "to shorewall.conf unless you did not install the Shell compiler."
	einfo
	einfo "Please read the included release notes for more information."
	einfo
	einfo "Known problems:"
	einfo "http://www1.shorewall.net/pub/${MY_PN}/${MY_PV_TREE}/${MY_P}/known_problems.txt"
	einfo
}
