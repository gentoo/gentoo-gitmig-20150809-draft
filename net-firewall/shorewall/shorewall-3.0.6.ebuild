# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/shorewall/shorewall-3.0.6.ebuild,v 1.1 2006/04/18 22:46:05 vanquirius Exp $

MY_P_DOCS="${P/${PN}/${PN}-docs-html}"

DESCRIPTION="Full state iptables firewall"
HOMEPAGE="http://www.shorewall.net/"
SRC_URI="http://shorewall.net/pub/${PN}/3.0/${P}/${P}.tgz
	doc? ( http://shorewall.net/pub/${PN}/3.0/${P}/${MY_P_DOCS}.tgz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc"

DEPEND="virtual/libc
	>=net-firewall/iptables-1.2.4
	sys-apps/iproute2"

src_compile() {
	einfo "Nothing to compile."
}

src_install() {
	keepdir /var/lib/shorewall

	PREFIX="${D}" ./install.sh || die "install.sh failed"
	newinitd "${FILESDIR}"/shorewall-r1 shorewall || die "doinitd failed"

	dodoc changelog.txt releasenotes.txt
	if use doc; then
		cd "${WORKDIR}/${MY_P_DOCS}"
		# install documentation
		dohtml -r *
		dosym Documentation_Index.html "/usr/share/doc/${PF}/html/index.htm"
		# install samples
		cp -pR "${S}/Samples" "${D}/usr/share/doc/${PF}"
	fi
}

pkg_postinst() {
	einfo
	if use doc ; then
		einfo "Documentation is available at /usr/share/doc/${PF}/html."
		einfo "Samples are available at /usr/share/doc/${PF}/Samples."
	else
		einfo "Documentation is available at http://www.shorewall.net"
	fi
	einfo "Do not blindly start shorewall, edit the files in /etc/shorewall first"
	einfo "At the very least, you must change 'STARTUP_ENABLED' in shorewall.conf"
	einfo
	einfo "If you intend to use the 2.6 IPSEC Support, you must retrieve the"
	einfo "kernel patches from http://shorewall.net/pub/shorewall/contrib/IPSEC/"
	einfo "or install kernel 2.6.16+ and compile it with support for policy match."
	einfo
	einfo "Be aware that version 3 differs substantially from previous releases."
	einfo "Information on upgrading is available at:"
	einfo "http://www.shorewall.net/upgrade_issues.htm"
	einfo
	einfo "Known problems:"
	einfo "http://shorewall.net/pub/${PN}/3.0/${P}/known_problems.txt"
}
