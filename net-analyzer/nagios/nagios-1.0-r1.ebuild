# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nagios/nagios-1.0-r1.ebuild,v 1.3 2003/08/05 17:55:03 vapier Exp $

DESCRIPTION="Nagios ${PV} - merge this to pull install all of the nagios packages"
HOMEPAGE="http://www.nagios.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc ~ppc"

RDEPEND=">=net-analyzer/nagios-core-1.0
	>=net-analyzer/nagios-plugins-1.3.0_beta2
	>=net-analyzer/nagios-nrpe-1.7
	>=net-analyzer/nagios-nsca-2.2
	>=net-analyzer/nagios-imagepack-1.0"

pkg_postinst() {
	einfo
	einfo "Remember to edit the config files in /etc/nagios"
	einfo "Also, if you want nagios to start at boot time"
	einfo "remember to execute rc-update add nagios default"
	einfo
	einfo "To have nagios visable on the web, please do the following:"
	einfo "1. Execute the command:"
	einfo " \"ebuild /var/db/pkg/net-analyzer/nagios-core-${PV}-r1/nagios-core-${PV}-r1.ebuild config\""
	einfo " 2. Edit /etc/conf.d/apache and add \"-D NAGIOS\""
	einfo
	einfo "That will make nagios's web front end visable via"
	einfo "http://localhost/nagios/"
	einfo
	einfo "The Apache config file for nagios will be in"
	einfo "/etc/apache/conf/addon-modules/ with the name of"
	einfo "nagios.conf."
	einfo "Also, if your kernel has /proc protection, nagios"
	einfo "will not be happy as it relies on accessing the proc"
	einfo "filesystem."
	einfo
}
