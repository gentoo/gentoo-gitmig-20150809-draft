# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_jk/mod_jk-1.2.22_pre.ebuild,v 1.1 2007/04/02 15:22:39 wltjr Exp $

inherit apache-module autotools

MY_P="tomcat-connectors-${PV/2.22_pre/1.22-dev-524775}-src"

KEYWORDS="~amd64 ~ppc ~x86"

DESCRIPTION="JK module for connecting Tomcat and Apache using the ajp13 protocol."
HOMEPAGE="http://tomcat.apache.org/connectors-doc/"
#SRC_URI="mirror://apache/tomcat/tomcat-connectors/jk/source/jk-${PV}/${MY_P}.tar.gz"
SRC_URI="http://people.apache.org/~mturk/jk-1.2.22-dev/${MY_P}.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
IUSE=""


S="${WORKDIR}/${MY_P}/native"

APACHE1_MOD_FILE="${S}/apache-1.3/${PN}.so"
APACHE1_MOD_CONF="88_${PN}"
APACHE1_MOD_DEFINE="JK"

APACHE2_MOD_FILE="${S}/apache-2.0/${PN}.so"
APACHE2_MOD_CONF="88_${PN}"
APACHE2_MOD_DEFINE="JK"

DOCFILES="CHANGES.txt README"

need_apache

src_unpack() {
	unpack ${A}
	cd "${S}"

	eautoreconf
}

src_compile() {
	local apxs
	use apache2 && apxs="${APXS2}"
	use apache2 || apxs="${APXS1}"

	econf \
		--with-apxs=${apxs} \
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

	if ! use apache2 ; then
		sed -i -e 's:/apache2/:/apache/:' "${D}${APACHE_CONFDIR}/modules.d/88_${PN}.conf" \
			|| die "Could not update jk-workers.properties for apache"
	fi
}

pkg_postinst() {
	elog "Tomcat is not a dependency of mod_jk any longer, if you intend"
	elog "to use it with Tomcat, you have to merge www-servers/tomcat on"
	elog "your own."
}
