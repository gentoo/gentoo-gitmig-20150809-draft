# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/jetty/jetty-4.2.19.ebuild,v 1.3 2004/07/27 11:23:54 axxo Exp $

inherit eutils

DESCRIPTION="A Lightweight Servlet Engine"
SRC_URI="http://dl.sourceforge.net/sourceforge/jetty/${PN/j/J}-${PV}-all.tar.gz"
HOMEPAGE="http://www.mortbay.org/"
KEYWORDS="~x86 ~ppc ~sparc"
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
	cp -Rdp * ${D}/${JETTY_HOME}
	dosym ${JETTY_HOME}/etc /etc/jetty
	ln -sf /var/log/jetty ${D}/opt/jetty/logs
}

pkg_postinst() {
	einfo
	einfo " NOTICE!"
	einfo " User and group 'jetty' have been added."
	einfo " "
	einfo " FILE LOCATIONS:"
	einfo " 1.  Jetty home directory: ${JETTY_HOME}"
	einfo "     Contains application data, configuration files."
	einfo " 2.  Runtime settings: /etc/conf.d/jetty"
	einfo "     Contains CLASSPATH,JAVA_HOME,JAVA_OPTIONS,JETTY_PORT"
	einfo "              JETTY_USER,JETTY_CONF setting"
	einfo " 3.  You can configure your 'webapp'-lications in /etc/jetty.conf"
	einfo "     (the default configured webapps are the JETTY's demo/admin)"
	einfo " 4.  For more information about JETTY refer to jetty.mortbay.org"
	einfo " 5.  Logs are located at:"
	einfo "                              /var/log/jetty/"
	einfo
	einfo " STARTING AND STOPPING JETTY:"
	einfo "   /etc/init.d/jetty start"
	einfo "   /etc/init.d/jetty stop"
	einfo "   /etc/init.d/jetty restart"
	einfo " "
	einfo " "
	einfo " NETWORK CONFIGURATION:"
	einfo " By default, Jetty runs on port 8080.  You can change this"
	einfo " value by setting JETTY_PORT in /etc/conf.d/jetty ."
	einfo " "
	einfo " To test Jetty while it's running, point your web browser to:"
	einfo " http://localhost:8080/"
	einfo
	einfo " BUGS:"
	einfo " Please file any bugs at http://bugs.gentoo.org/ or else it"
	einfo " may not get seen. Thank you!"
	einfo
}
