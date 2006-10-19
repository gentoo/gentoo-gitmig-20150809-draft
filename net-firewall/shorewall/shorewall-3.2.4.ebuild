# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/shorewall/shorewall-3.2.4.ebuild,v 1.3 2006/10/19 14:01:29 gustavoz Exp $

MY_P_DOCS="${P/${PN}/${PN}-docs-html}"

DESCRIPTION="Shoreline Firewall is an iptables-based firewall for Linux."
HOMEPAGE="http://www.shorewall.net/"
SRC_URI="http://shorewall.net/pub/${PN}/3.2/${P}/${P}.tgz
	doc? ( http://shorewall.net/pub/${PN}/3.2/${P}/${MY_P_DOCS}.tgz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~sparc ~x86"
IUSE="doc"

DEPEND=">=net-firewall/iptables-1.2.4
	sys-apps/iproute2"

src_compile() {
	einfo "Nothing to compile."
}

src_install() {
	keepdir /var/lib/shorewall

	PREFIX="${D}" ./install.sh || die "install.sh failed"
	newinitd "${FILESDIR}"/shorewall-r2 shorewall || die "doinitd failed"

	dodoc changelog.txt releasenotes.txt
	if use doc; then
		cd "${WORKDIR}/${MY_P_DOCS}"
		# install documentation
		dohtml -r *
		## dosym Documentation_Index.html "/usr/share/doc/${PF}/html/index.htm"
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
	einfo "or install kernel 2.6.16+ as well as a recent Netfilter iptables"
	einfo "and compile it with support for policy match."
	einfo
	einfo "Be aware that version 3.2 differs substantially from previous releases."
	einfo "Information on upgrading is available at:"
	einfo "http://www.shorewall.net/upgrade_issues.htm"
	einfo
	einfo "If you are upgrading to 3.2 you should at least:"
	einfo "* check that /etc/shorewall/rfc1918 does not contain non-RFC1918 private"
	einfo "  addresses. If it does, rename it to rfc1918.old"
	einfo "* remove /etc/shorewall/modules and use the one in /usr/share/shorewall/"
	einfo "* review IMAP LDAP NNTP POP3 SMTP and WEB macros as they have changed"
	einfo
	einfo "There is a new 'shorewall compile' command to generate scripts to run"
	einfo "on systems with Shorewall Lite installed."
	einfo "Please refer to http://www.shorewall.net/CompiledPrograms.html"
	einfo "It is advised to copy the /usr/share/shorewall/configfiles dir to your"
	einfo "own 'export directories'. However, whenever you upgrade Shorewall you"
	einfo "should check for changes in configfiles and manually update your exports."
	einfo "Alternatively, if you only have one Shorewall-Lite system in your network"
	einfo "then you can use the configfiles dir but set CONFIG_PROTECT appropriately"
	einfo "in /etc/make.conf (man make.conf)."
	einfo
	einfo "Known problems:"
	einfo "http://shorewall.net/pub/${PN}/3.2/${P}/known_problems.txt"
	einfo
	einfo "Whether upgrading or installing you should run shorewall check,"
	einfo "correct any errors found and run shorewall restart|start."
}
