# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/apachetop/apachetop-0.5.ebuild,v 1.3 2004/03/30 22:44:55 zul Exp $

MY_P="ApacheTop-${PV}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="A realtime Apache log analyzer"
HOMEPAGE="http://clueful.shagged.org/apachetop/"
SRC_URI="http://clueful.shagged.org/apachetop/files/${P}.tar.gz"

IUSE="apache2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc"

DEPEND="!apache2? ( >=net-www/apache-1.3.28 )
	apache2? ( >=net-www/apache-2.0.47 )
	sys-apps/sed"

src_compile() {
	if use apache2
	then
		sed -i 's%DEFAULT_LOGFILE "/var/httpd/apache_log"%DEFAULT_LOGFILE "/etc/apache2/logs/access_log"%' *
	else
		sed -i 's%DEFAULT_LOGFILE "/var/httpd/apache_log"%DEFAULT_LOGFILE "/etc/apache/logs/access_log"%' *
	fi
	emake linux || die
}

src_install() {
	dobin apachetop || die
}
