# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/shorewall-perl/shorewall-perl-4.0.3.ebuild,v 1.4 2007/09/09 14:40:48 josejx Exp $

# Choose between experimental, stable and beta:
#MY_P_TREE="development/4.0"  # experimental and beta
MY_P_TREE="4.0"             # stable
#MY_P_BETA="-Beta7"           # only beta
MY_P_BETA=""                # stable or experimental

MY_P="shorewall-${PV}"

DESCRIPTION="Shoreline Firewall Perl-based compiler that allows faster compilation and execution."
HOMEPAGE="http://www.shorewall.net/"
SRC_URI="http://www1.shorewall.net/pub/shorewall/${MY_P_TREE}/${MY_P}${MY_P_BETA}/${P}${MY_P_BETA}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND="net-firewall/iptables
	sys-apps/iproute2
	dev-lang/perl
	!<et-firewall/shorewall-4.0"

PDEPEND="~net-firewall/shorewall-common-${PV}"

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
	einfo "In order to use the Perl compiler you need to add"
	einfo "SHOREWALL_COMPILER=perl"
	einfo "to shorewall.conf"
	einfo
	einfo "Please read the included release notes for more information."
	einfo
	einfo "Known problems:"
	einfo "http://www1.shorewall.net/pub/shorewall/${MY_P_TREE}/${MY_P}${MY_P_BETA}/known_problems.txt"
	einfo
}
