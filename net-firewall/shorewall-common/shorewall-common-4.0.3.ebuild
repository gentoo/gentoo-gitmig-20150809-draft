# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/shorewall-common/shorewall-common-4.0.3.ebuild,v 1.3 2007/09/07 20:23:05 jer Exp $

inherit eutils

# Choose between experimental, stable and beta:
#MY_P_TREE="development/4.0"  # experimental and beta
MY_P_TREE="4.0"             # stable
#MY_P_BETA="-RC1"             # only beta and RC
MY_P_BETA=""                # stable or experimental

MY_P="${P/-common/}${MY_P_BETA}"
MY_PN="${PN/-common/}"

MY_P_DOCS="${MY_P/${MY_PN}/${MY_PN}-docs-html}"

DESCRIPTION="Shoreline Firewall is an iptables-based firewall for Linux."
HOMEPAGE="http://www.shorewall.net/"
SRC_URI="http://www1.shorewall.net/pub/${MY_PN}/${MY_P_TREE}/${MY_P}/${P}${MY_P_BETA}.tar.bz2
	doc? ( http://www1.shorewall.net/pub/${MY_PN}/${MY_P_TREE}/${MY_P}/${MY_P_DOCS}.tar.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE="doc"

DEPEND=">=net-firewall/iptables-1.2.4
	sys-apps/iproute2
	~net-firewall/shorewall-shell-${PV}
	!<net-firewall/shorewall-4.0"

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

	cd "${WORKDIR}/${P}${MY_P_BETA}"
	PREFIX="${D}" ./install.sh || die "install.sh failed"
	newinitd "${FILESDIR}"/shorewall.initd shorewall || die "doinitd failed"

	dodoc changelog.txt releasenotes.txt
	if use doc; then
		cd "${WORKDIR}/${MY_P_DOCS}"
		# install documentation
		dohtml -r *
		## dosym Documentation_Index.html "/usr/share/doc/${PF}/html/index.htm"
		# install samples
		cp -pR "${S}${MY_P_BETA}/Samples" "${D}/usr/share/doc/${PF}"
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
	elog "Bridging configuration has changed with kernel 2.6.20+."
	elog "Check the documentation."
	elog
	elog "Do not blindly start shorewall, edit the files in /etc/shorewall first"
	elog "At the very least, you must change 'STARTUP_ENABLED' in shorewall.conf"
	elog
	elog "Be aware that version ${MY_P_TREE} differs substantially from previous releases."
	elog "Information on upgrading is available at:"
	elog "http://www.shorewall.net/upgrade_issues.htm"
	elog
	elog "There is a 'shorewall compile' command to generate scripts to run"
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
	elog "http://shorewall.net/pub/${MY_PN}/${MY_P_TREE}/${MY_P}/known_problems.txt"
	elog
	elog "Whether upgrading or installing you should run shorewall check,"
	elog "correct any errors found and run shorewall restart|start."
	elog
	elog "${PN} requires a compiler."
	elog "You can choose to emerge shorewall-shell and/or shorewall-perl."
	elog "As of ${PV} shorewall-shell is mandatory."
}
