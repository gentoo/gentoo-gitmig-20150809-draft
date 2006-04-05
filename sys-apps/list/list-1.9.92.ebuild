# Copyright 2005-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/list/list-1.9.92.ebuild,v 1.3 2006/04/05 21:34:20 twp Exp $


inherit eutils

DESCRIPTION="Python client from www.linux-stats.org to collect your hardware and to generate statistics about linux-systems."
HOMEPAGE="http://www.linux-stats.org/"
SRC_URI="http://www.linux-stats.org/download/LiSt-${PV}.tar.bz2"

KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~x86"
LICENSE="GPL-2"
RESTRICT=""
SLOT="0"

IUSE=""
RDEPEND=">=dev-lang/python-2.4.0
	>=net-misc/wget-1.10.2
	>=sys-apps/sed-4.1.4
	>=sys-apps/util-linux-2.12r
	!sys-apps/hexdump-esr"

S=${WORKDIR}/LiSt-${PV}

pkg_setup() {
	einfo "Adding new group \"stats\"..."
	enewgroup stats
}

src_install() {
	declare CONFIGDIR=/etc/LiSt
	dodir ${CONFIGDIR}
	fowners root:stats ${CONFIGDIR}
	fperms g+wx ${CONFIGDIR}
	dobin src/LiSt
	cd doc
	dodoc README INSTALL AUTHORS
}

pkg_postinst() {
	echo ""
	ewarn "+---------------------------------------------------+"
	ewarn "| You have to be in the stats group to use this     |"
	ewarn "| software! You can add yourself to the stats group |"
	ewarn "| by running the following command:                 |"
	ewarn "|                                                   |"
	ewarn "|     gpasswd -a <user> stats                       |"
	ewarn "|                                                   |"
	ewarn "| Then you have to re-login with your user!         |"
	ewarn "+---------------------------------------------------+"
	ewarn "| Start this application by typing \"LiSt\" in your   |"
	ewarn "| console. To get some help, try \"LiSt -h\".         |"
	ewarn "| To run this application every 24h in a cronjob,   |"
	ewarn "| add the following to \"crontab -e\":                |"
	ewarn "|                                                   |"
	ewarn "| 0 12 * * * /usr/bin/LiSt -uy &>/dev/null          |"
	ewarn "+---------------------------------------------------+"
	ewarn "| Please read also the following README:            |"
	ewarn "| /usr/share/doc/${PF}/README.gz              |"
	ewarn "+---------------------------------------------------+"
	echo ""
}
