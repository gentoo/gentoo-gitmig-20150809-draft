# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/kmyfirewall/kmyfirewall-1.0.1-r1.ebuild,v 1.2 2007/05/06 09:56:45 genone Exp $

inherit kde eutils

MY_P="${P/_/}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Graphical KDE iptables configuration tool"
HOMEPAGE="http://kmyfirewall.sourceforge.net/"
SRC_URI="mirror://sourceforge/kmyfirewall/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc sparc x86"
IUSE=""

RDEPEND="net-firewall/iptables"
need-kde 3

src_unpack() {
	kde_src_unpack
	echo -e "[PATHS]\nDistribution=gentoo\nIPTPath=${ROOT}sbin/iptables\nModprobePath=${ROOT}sbin/modprobe\nrcDefaultPath=${ROOT}etc/runlevels/default/" >> ${S}/kmyfirewall/kmyfirewallrc}
}

src_install() {
	kde_src_install

	# search path is broken in the app, help it temporarily
	dosym kpartplugins/kmfinstallerpluginui.rc /usr/share/apps/kmyfirewall/kmfinstallerpluginui.rc
}

pkg_postinst() {
	make_desktop_entry m "Kmyfirewall" kmyfirewall
	elog
	elog "Only run-as-user menuentry provided. If you want to directly"
	elog "run kmyfirewall as root (inside kdesu), just check:"
	elog "run-as-other-user inside the menu edit,leving blank the field"
	elog
}
