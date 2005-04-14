# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_jk/mod_jk-1.2.10.ebuild,v 1.1 2005/04/14 19:37:59 luckyduck Exp $

inherit apache-module

MY_P="jakarta-tomcat-connectors-${PV}-src"

DESCRIPTION="JK module for connecting Tomcat and Apache using the ajp13 protocol"
HOMEPAGE="http://jakarta.apache.org/tomcat/connectors-doc/jk2/index.html"
SRC_URI="mirror://apache/jakarta/tomcat-connectors/jk/source/jk-${PV}/${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="apache2"

DEPEND=">=virtual/jdk-1.4
	>=www-servers/tomcat-5.0.28"
S="${WORKDIR}/${MY_P}/jk/native"

APACHE1_MOD_FILE="${S}/apache-1.3/mod_jk.so"
APACHE1_MOD_CONF="88_${PN}"
APACHE1_MOD_DEFINE="JK"

APACHE2_MOD_FILE="${S}/apache-2.0/mod_jk.so"
APACHE2_MOD_CONF="88_${PN}"
APACHE2_MOD_DEFINE="JK"

DOCFILES="CHANGES.txt README"

need_apache

src_compile() {
	local apxs
	use apache2 && apxs="${APXS2}"
	use apache2 || apxs="${APXS1}"

	econf \
		--with-apxs=${apxs} \
		--with-apr-config=/usr/bin/apr-config \
		|| die "econf failed"
	emake LIBTOOL="/bin/sh `pwd`/libtool --silent" || die "make failed"
}

src_install() {
	# install the workers.properties file
	local confdir=""
	use apache2 && confdir="/etc/apache2"
	use apache2 || confdir="/etc/apache"

	dodir ${confdir}
	insinto ${confdir}
	doins ${FILESDIR}/jk-workers.properties

	# call the nifty default src_install :-)
	apache-module_src_install
}
