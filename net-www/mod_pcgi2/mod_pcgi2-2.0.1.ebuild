# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_pcgi2/mod_pcgi2-2.0.1.ebuild,v 1.2 2003/08/15 06:25:09 robbat2 Exp $

apachedir='1'
apache=''
use apache2 && apache=2 apachedir=2

DESCRIPTION="An Apache module to talk to Zope Corporation's PCGI"
HOMEPAGE="http://www.zope.org/Members/phd/${PN}/"
SRC_URI="http://zope.org/Members/phd/${PN}/${PV}/${P}-src.tar.gz"
LICENSE="GPL-2"
SLOT="${apachedir}"
KEYWORDS="~x86"
IUSE="apache2"

DEPEND="${DEPEND}
		net-www/apache
		apache2? ( >=net-www/apache-2 )
		net-www/pcgi"
#RDEPEND=""
S=${WORKDIR}/${PN/mod_}

src_compile() {
	if use apache2; then
		apxs2 \
		-n pcgi2  \
		-DUNIX -DAPACHE2 -DMOD_PCGI2 \
		-c mod_pcgi2.c pcgi-wrapper.c parseinfo.c 
		#-o mod_pcgi.so \
	else
		apxs \
		-Wc,-DMOD_PCGI2 \
		-Wc,-DUNIX  \
		-Wc,-DHAVE_UNION_SEMUN  \
		-I./  \
		-o mod_pcgi2.so \
		-c mod_pcgi2.c parseinfo.c pcgi-wrapper.c 
	fi
}

src_install() {
	dodoc NEWS README TODO ChangeLog
	exeinto /usr/lib/apache${apache}-extramodules
	doexe .libs/${PN}.so
	insinto /etc/apache${apache}/conf/modules.d
	doins ${FILESDIR}/20_mod_pcgi.conf
}
