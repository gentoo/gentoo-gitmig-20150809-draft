# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_scgi/mod_scgi-1.2_alpha1.ebuild,v 1.4 2003/09/06 01:54:08 msterret Exp $

apachedir='1'
apache=''
use apache2 && apache=2 apachedir=2

P0=${P/mod_/}
MY_P=${P0/_alpha/a}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Apache module for a Replacement for the CGI protocol that is similar to FastCGI"
HOMEPAGE="http://www.mems-exchange.org/software/scgi/"
SRC_URI="http://www.mems-exchange.org/software/files/${PN}/${MY_P}.tar.gz"
LICENSE="CNRI"
SLOT="${apachedir}"
KEYWORDS="~x86"
IUSE="apache2"
DEPEND="${DEPEND}
		net-www/scgi
		net-www/apache
		apache2? ( >=net-www/apache-2 )"

src_compile() {
	cd apache${apachedir}
	make || die "apache${apachedir} mod_scgi make failed"
}

src_install() {
	newdoc apache1/README README.apache1
	newdoc apache2/README README.apache2
	dodoc README PKG-INFO LICENSE.txt CHANGES
	exeinto /usr/lib/apache${apache}-extramodules
	doexe apache${apachedir}/.libs/${PN}.so
	insinto /etc/apache${apache}/conf/modules.d
	doins ${FILESDIR}/20_mod_scgi.conf
}
