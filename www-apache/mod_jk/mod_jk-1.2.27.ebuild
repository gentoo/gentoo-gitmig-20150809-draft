# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_jk/mod_jk-1.2.27.ebuild,v 1.2 2009/04/18 08:18:16 nixnut Exp $

inherit apache-module java-pkg-2

MY_P="tomcat-connectors-${PV}-src"

KEYWORDS="~amd64 ppc ~x86"

DESCRIPTION="JK module for connecting Tomcat and Apache using the ajp13 protocol."
HOMEPAGE="http://tomcat.apache.org/connectors-doc/"
SRC_URI="mirror://apache/tomcat/tomcat-connectors/jk/source/jk-${PV}/${MY_P}.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

S="${WORKDIR}/${MY_P}/native"

APACHE2_MOD_FILE="${S}/apache-2.0/${PN}.so"
APACHE2_MOD_CONF="88_${PN}"
APACHE2_MOD_DEFINE="JK"

DOCFILES="CHANGES"
CONF_DIR="${WORKDIR}/${MY_P}/conf"
need_apache

DEPEND=">=virtual/jdk-1.4"

src_compile() {
	econf \
		--with-apxs=${APXS} \
		--with-apr-config=/usr/bin/apr-config \
		|| die "econf failed"
	emake LIBTOOL="/bin/sh $(pwd)/libtool --silent" || die "emake failed"
}

src_install() {
	# install the workers.properties file
	insinto "${APACHE_CONFDIR}"
	doins "${CONF_DIR}/workers.properties"
	doins "${CONF_DIR}/uriworkermap.properties"

	# call the nifty default src_install :-)
	apache-module_src_install
}

pkg_postinst() {
	elog "Tomcat is not a dependency of mod_jk any longer, if you intend"
	elog "to use it with Tomcat, you have to merge www-servers/tomcat on"
	elog "your own."

	elog "Advanced Directives and Options can be found at: "
	elog "http://tomcat.apache.org/connectors-doc/reference/workers.html"
}
