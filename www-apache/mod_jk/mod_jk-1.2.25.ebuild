# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_jk/mod_jk-1.2.25.ebuild,v 1.1 2007/08/10 21:40:36 wltjr Exp $

inherit apache-module autotools

MY_P="tomcat-connectors-${PV}-src"

KEYWORDS="amd64 ppc x86"

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

DOCFILES="CHANGES README"

need_apache

src_unpack() {
	unpack ${A}
	cd "${S}"

	eautoreconf
}

src_compile() {
	econf \
		--with-apxs=${APXS2} \
		--with-apr-config=/usr/bin/apr-config \
		|| die "econf failed"
	emake LIBTOOL="/bin/sh $(pwd)/libtool --silent" || die "emake failed"
}

src_install() {
	# install the workers.properties file
	insinto "${APACHE_CONFDIR}"
	doins "${FILESDIR}/jk-workers.properties"

	# call the nifty default src_install :-)
	apache-module_src_install
}

pkg_postinst() {
	elog "Tomcat is not a dependency of mod_jk any longer, if you intend"
	elog "to use it with Tomcat, you have to merge www-servers/tomcat on"
	elog "your own."
}
