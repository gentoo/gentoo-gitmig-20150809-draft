# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/kmyfirewall/kmyfirewall-1.1.1.ebuild,v 1.1 2008/05/06 07:19:06 pva Exp $

inherit kde eutils

MY_P="${P/_/}"
DESCRIPTION="Graphical KDE iptables configuration tool"
HOMEPAGE="http://www.kmyfirewall.org/"
SRC_URI="mirror://sourceforge/kmyfirewall/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="net-firewall/iptables"

S=${WORKDIR}/${MY_P}

need-kde 3

src_unpack() {
	kde_src_unpack
	cat > "${S}"/kmyfirewall/kmyfirewallrc <<-EOF
	[PATHS]
	Distribution=gentoo
	IPTPath=/sbin/iptables
	ModprobePath=/sbin/modprobe
	rcDefaultPath=/etc/runlevels/default/
	EOF

	epatch "${FILESDIR}"/${P}-interfaces-crash.patch
}

src_install() {
	kde_src_install

	# search path is broken in the app, help it temporarily
	dosym {kpartplugins,/usr/share/apps/kmyfirewall}/kmfinstallerpluginui.rc
	dosym {kpartplugins,/usr/share/apps/kmyfirewall}/kmfinstallerpluginui.rc
}

pkg_postinst() {
	elog
	elog "Only run-as-user menuentry provided. If you want to directly"
	elog "run kmyfirewall as root (inside kdesu), just check:"
	elog "run-as-other-user inside the menu edit,leving blank the field"
	elog
	ewarn "Use this version if you want to use the new generic interface"
	ewarn "For iptables interface using 0.9 series is heavily recommended"
	ewarn "See Bug #165429 for details"
}
