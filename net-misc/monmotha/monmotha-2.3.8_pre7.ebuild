# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/monmotha/monmotha-2.3.8_pre7.ebuild,v 1.1 2002/08/21 02:23:27 agenkin Exp $

DESCRIPTION="MonMotha IPTables-based firewall script."
HOMEPAGE="http://monmotha.mplug.org/firewall/"
LICENSE="GPL-2"

KEYWORDS="x86"
SLOT="0"
RDEPEND=">=sys-apps/iptables-1.2.5"

src_install() {
	exeinto /etc/init.d
	newexe "${FILESDIR}/monmotha.rc6" monmotha
	exeinto /etc/monmotha
	newexe "${FILESDIR}/rc.firewall-${PV/_pre/-pre}" monmotha
}

pkg_postinst () {
	einfo "Don't forget to add the Script to your default"
	einfo "Runlevel by typing the following Command:"
	einfo ""
	einfo "	 rc-update add monmotha default"
	einfo ""
	einfo "You need to edit /etc/monmotha/monmotha before using"
	einfo "the Script. Enter the right Vars in the File, start the Script"
	einfo "by typing: /etc/init.d/monmotha start and it should work"
	einfo ""
	einfo "Don't forget to change the Path to iptables!!!"
	einfo ""
	einfo "Note: If You are stopping the Firewall, all iptables Rulesets"
	einfo "will be Flushed!!!"
	einfo ""
}
