# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/kmyfirewall/kmyfirewall-1.0-r2.ebuild,v 1.1 2005/12/15 19:33:39 vanquirius Exp $

inherit kde eutils

MY_P="${P/_/}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Graphical KDE iptables configuration tool"
HOMEPAGE="http://kmyfirewall.sourceforge.net/"
SRC_URI="mirror://sourceforge/kmyfirewall/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="net-firewall/iptables"
need-kde 3

src_unpack() {
	kde_src_unpack

	echo -e "[PATHS]\nDistribution=gentoo\nIPTPath=${ROOT}sbin/iptables\nModprobePath=${ROOT}sbin/modprobe\nrcDefaultPath=${ROOT}etc/runlevels/default/" >> ${S}/kmyfirewall/kmyfirewallrc

	epatch "${FILESDIR}/kmyfirewall-1.0_gentoo_multiport.diff"
	epatch "${FILESDIR}/${PN}-1.0-logprefix.diff"
}
