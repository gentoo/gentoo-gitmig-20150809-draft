# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/shorewall/shorewall-3.4.6.ebuild,v 1.6 2007/09/09 16:33:18 armin76 Exp $

inherit eutils

#MY_P_TREE="development/3.9"
MY_P_TREE="3.4"
MY_P_DOCS="${P/${PN}/${PN}-docs-html}"

DESCRIPTION="Shoreline Firewall is an iptables-based firewall for Linux."
HOMEPAGE="http://www.shorewall.net/"
SRC_URI="http://www1.shorewall.net/pub/${PN}/${MY_P_TREE}/${P}/${P}.tgz
	doc? ( http://www1.shorewall.net/pub/${PN}/${MY_P_TREE}/${P}/${MY_P_DOCS}.tgz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 hppa ~mips ppc ppc64 sparc x86"
IUSE="doc"

DEPEND=">=net-firewall/iptables-1.2.4
	sys-apps/iproute2"

# When we're ready for 3.9.x...
#RDEPEND="|| (
#	>=net-firewall/shorewall-shell-3.9.1
#	>=net-firewall/shorewall-perl-3.9.1
#	)"

pkg_setup() {
	if built_with_use sys-apps/iproute2 minimal; then
		die "Shorewall requires sys-apps/iproute2 to be built without the \"minimal\" USE flag."
	fi
}

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
	elog
	if use doc ; then
		elog "Documentation is available at /usr/share/doc/${PF}/html."
		elog "Please read the Release Notes in /usr/share/doc/${PF}."
		elog "Samples are available at /usr/share/doc/${PF}/Samples."
	else
		elog "Documentation is available at http://www.shorewall.net"
	fi
	elog "There are man pages for shorewall(8) and for each configuration file."
	elog
	elog "Bridging configuration has changed with kernel 2.6.20+. Check the documentation."
	elog
	elog "Do not blindly start shorewall, edit the files in /etc/shorewall first"
	elog "At the very least, you must change 'STARTUP_ENABLED' in shorewall.conf"
	elog
	elog "If you intend to use the 2.6 IPSEC Support, you must retrieve the"
	elog "kernel patches from http://shorewall.net/pub/shorewall/contrib/IPSEC/"
	elog "or install kernel 2.6.16+ as well as a recent Netfilter iptables"
	elog "and compile it with support for policy match."
	elog
	elog "Be aware that version ${MY_P_TREE} differs substantially from previous releases."
	elog "Information on upgrading is available at:"
	elog "http://www.shorewall.net/upgrade_issues.htm"
	elog
	elog "If you are upgrading to ${MY_P_TREE} you should at least:"
	elog "* check that /etc/shorewall/rfc1918 does not contain non-RFC1918 private"
	elog "  addresses. If it does, rename it to rfc1918.old"
	elog "* remove /etc/shorewall/modules and use the one in /usr/share/shorewall/"
	elog "* review IMAP LDAP NNTP POP3 SMTP and WEB macros as they have changed"
	elog "* move any policy's default action specifications"
	elog "  from /etc/shorewall/actions to /etc/shorewall/shorewall.conf"
	elog "* remove or rename custom version of Limit action (if any)"
	elog "* entries in /etc/shorewall/providers require specific procedure at startup"
	elog
	elog "There is a new 'shorewall compile' command to generate scripts to run"
	elog "on systems with Shorewall Lite installed."
	elog "Please refer to http://www.shorewall.net/CompiledPrograms.html"
	elog "It is advised to copy the /usr/share/shorewall/configfiles dir to your"
	elog "own 'export directories'. However, whenever you upgrade Shorewall you"
	elog "should check for changes in configfiles and manually update your exports."
	elog "Alternatively, if you only have one Shorewall-Lite system in your network"
	elog "then you can use the configfiles dir but set CONFIG_PROTECT appropriately"
	elog "in /etc/make.conf (man make.conf)."
	elog
	elog "Known problems:"
	elog "http://shorewall.net/pub/${PN}/${MY_P_TREE}/${P}/known_problems.txt"
	elog
	elog "Whether upgrading or installing you should run shorewall check,"
	elog "correct any errors found and run shorewall restart|start."
	elog
}
