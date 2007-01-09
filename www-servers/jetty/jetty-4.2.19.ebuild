# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/jetty/jetty-4.2.19.ebuild,v 1.7 2007/01/09 15:45:36 caster Exp $

inherit eutils

DESCRIPTION="A Lightweight Servlet Engine"
SRC_URI="mirror://sourceforge/jetty/${PN/j/J}-${PV}-all.tar.gz"
HOMEPAGE="http://www.mortbay.org/"
KEYWORDS="~amd64 ~ppc ~x86"
LICENSE="Apache-1.1"
SLOT="0"
DEPEND=">=virtual/jdk-1.2
		dev-java/ant"
IUSE=""

S=${WORKDIR}/Jetty-${PV}

pkg_preinst() {
	enewgroup jetty
	enewuser jetty -1 /bin/bash /opt/jetty jetty
	chown -R jetty:jetty ${D}
}

src_install() {
	JETTY_HOME="/opt/jetty"
	INSTALLING="yes"
	diropts -m0750

	# Create directories
	dodir ${JETTY_HOME}
	dodir ${JETTY_HOME}/tmp
	keepdir ${JETTY_HOME}/tmp
	dodir /var/log/${PN}
	touch ${D}/var/log/${PN}/jetty.log
	keepdir /var/log/${PN}

	# INIT SCRIPTS AND ENV
	insinto /etc/init.d
	insopts -m0750
	newins ${FILESDIR}/${PV}/jetty.init jetty

	insinto /etc/env.d
	insopts -m0750
	doins ${FILESDIR}/${PV}/21jetty

	insinto /etc/
	insopts -m0644
	doins ${FILESDIR}/${PV}/jetty.conf

	insinto /etc/conf.d
	insopts -m0644
	doins ${FILESDIR}/${PV}/jetty

	dodoc *.TXT
	dohtml *.html

	chmod u+x ${S}/bin/jetty.sh

	ant
	cp -Rp * ${D}/${JETTY_HOME}
	dosym ${JETTY_HOME}/etc /etc/jetty
	ln -sf /var/log/jetty ${D}/opt/jetty/logs
}

pkg_postinst() {
	einfo
	einfo " NOTICE!"
	einfo " User and group 'jetty' have been added."
	einfo
	elog " FILE LOCATIONS:"
	elog " 1.  Jetty home directory: ${JETTY_HOME}"
	elog "     Contains application data, configuration files."
	elog " 2.  Runtime settings: /etc/conf.d/jetty"
	elog "     Contains CLASSPATH,JAVA_HOME,JAVA_OPTIONS,JETTY_PORT"
	elog "              JETTY_USER,JETTY_CONF setting"
	elog " 3.  You can configure your 'webapp'-lications in /etc/jetty.conf"
	elog "     (the default configured webapps are the JETTY's demo/admin)"
	elog " 4.  For more information about JETTY refer to jetty.mortbay.org"
	elog " 5.  Logs are located at:"
	elog "                              /var/log/jetty/"
	elog
	elog " STARTING AND STOPPING JETTY:"
	elog "   /etc/init.d/jetty start"
	elog "   /etc/init.d/jetty stop"
	elog "   /etc/init.d/jetty restart"
	elog
	elog
	elog " NETWORK CONFIGURATION:"
	elog " By default, Jetty runs on port 8080.  You can change this"
	elog " value by setting JETTY_PORT in /etc/conf.d/jetty ."
	elog
	elog " To test Jetty while it's running, point your web browser to:"
	elog " http://localhost:8080/"
	elog
	elog " BUGS:"
	elog " Please file any bugs at http://bugs.gentoo.org/ or else it"
	elog " may not get seen. Thank you!"
	elog
}
