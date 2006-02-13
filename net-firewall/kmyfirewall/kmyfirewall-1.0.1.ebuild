# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/kmyfirewall/kmyfirewall-1.0.1.ebuild,v 1.1 2006/02/13 15:54:01 jokey Exp $

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

	#cp files/m-kmyf*.desktop "${FILESDIR}/"
}

pkg_postinst() {
	make_desktop_entry m "Kmyfirewall" kmyfirewall
	einfo
	einfo "Only run-as-user menuentry provided. If you want to directly"
	einfo "run kmyfirewall as root (inside kdesu), just check:"
	einfo "run-as-other-user inside the menu edit,leving blank the field"
	einfo
}
