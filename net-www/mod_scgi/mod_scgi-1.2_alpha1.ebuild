# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_scgi/mod_scgi-1.2_alpha1.ebuild,v 1.1 2003/08/12 04:40:48 g2boojum Exp $

P0=${P/mod_/}
MY_P=${P0/_alpha/a}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Apache module for a Replacement for the CGI protocol that is similar to FastCGI"
HOMEPAGE="http://www.mems-exchange.org/software/scgi/"
SRC_URI="http://www.mems-exchange.org/software/files/${PN}/${MY_P}.tar.gz"
LICENSE="CNRI"
SLOT="0"
KEYWORDS="~x86"
IUSE="apache2"
DEPEND="net-www/scgi
		net-www/apache
		apache2? ( >=net-www/apache-2 )"

src_compile() {
	if [ -z "`use apache2`" ]
	then
		cd apache1
		make || die "apache1 mod_scgi make failed"
	else
		cd apache2
		make || die "apache2 mod_scgi make failed"
	fi
}

src_install() {
	if [ -z "`use apache2`" ]
	then
		cd apache1
		exeinto /usr/lib/apache-extramodules
		doexe .libs/${PN}.so
		dodoc README
		insinto /etc/apache/conf/modules.d
		doins ${FILESDIR}/20_mod_scgi.conf
	else
		cd apache2
		exeinto /usr/lib/apache2-extramodules
		doexe .libs/${PN}.so
		dodoc README
		insinto /etc/apache2/conf/modules.d
		doins ${FILESDIR}/20_mod_scgi.conf
	fi
}
