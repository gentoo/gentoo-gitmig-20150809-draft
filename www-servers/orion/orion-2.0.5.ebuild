# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/orion/orion-2.0.5.ebuild,v 1.7 2005/08/26 13:50:48 flameeyes Exp $

inherit eutils java-pkg

S=${WORKDIR}/${PN}

At=${PN}${PV}.zip

DESCRIPTION="Orion EJB/J2EE application webserver"
SRC_URI="http://www.orionserver.com/distributions/${At}"
HOMEPAGE="http://www.orionserver.com/"
KEYWORDS="~amd64 ~ppc ~sparc x86"
LICENSE="ORIONSERVER"
SLOT="0"
DEPEND=">=virtual/jdk-1.3
	app-arch/unzip"
IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}/${PV}-gentoo.patch
}

src_install() {
	# CREATE DIRECTORIES
	diropts -m0755
	dodir /opt/${PN}
	dodir /opt/${PN}/config
	dodir /opt/${PN}/sbin
	dodir /var/log/${PN}

	cd ${S}

	# INSTALL STARTUP SCRIPTS
	insinto /opt/orion/sbin
	insopts -m0750
	doins ${FILESDIR}/${PV}/start_orion.sh
	doins ${FILESDIR}/${PV}/stop_orion.sh

	newinitd ${FILESDIR}/${PV}/orion.init orion
	newconfd ${FILESDIR}/${PV}/orion.conf orion

	# CREATE DUMMY LOG & PERSISTENCE DIR
	dodir /var/log/${PN}
	dodir /opt/${PN}/persistence

	keepdir /var/log/${PN}
	keepdir /opt/${PN}/persistence

	# INSTALL EXTRA FILES
	local dirs="applications default-web-app demo lib persistence autoupdate.properties"
	for i in $dirs ; do
		cp -pPR ${i} ${D}/opt/${PN}/
	done

	# INSTALL APP CONFIG
	cd ${S}/config
	local dirs="application.xml data-sources.xml database-schemas default-web-site.xml global-web-application.xml jms.xml mime.types principals.xml rmi.xml server.xml"
	for i in $dirs ; do
		cp -pPR ${i} ${D}/opt/${PN}/config
	done

	# INSTALL JARS
	cd ${S}
	for i in *.jar ; do
		java-pkg_dojar $i
	done

	# LINK IN SDK TOOLS.JAR
	dosym ${JAVA_HOME}/lib/tools.jar /usr/share/${PN}/lib/tools.jar

	# INSTALL DOCS
	dodoc Readme.txt changes.txt
}

pkg_preinst() {
	enewgroup orion
	enewuser orion -1 /bin/bash /opt/orion orion
	chown -R orion:orion ${IMAGE}/opt/${PN}
	chown -R orion:orion ${IMAGE}/var/log/${PN}
	chown root:0 ${IMAGE}/etc/conf.d/orion
}

pkg_postinst() {
	einfo
	einfo " NOTICE!"
	einfo " User and group 'orion' have been added."
	einfo " Please set a password for the user account 'orion'"
	einfo " if you have not done so already."
	einfo
	einfo
	einfo " FILE LOCATIONS:"
	einfo " 1.  Orion home directory: /opt/orion"
	einfo "     Contains application data, configuration files."
	einfo " 2.  Runtime settings: /etc/conf.d/orion"
	einfo "     Contains CLASSPATH and JDK settings."
	einfo " 3.  Logs:  /var/log/orion/"
	einfo " 4.  Executables, libraries:  /usr/share/${PN}/"
	einfo
	einfo
	einfo " STARTING AND STOPPING ORION:"
	einfo "   /etc/init.d/orion start"
	einfo "   /etc/init.d/orion stop"
	einfo "   /etc/init.d/orion restart"
	einfo
	einfo
	einfo " NETWORK CONFIGURATION:"
	einfo " By default, Orion runs on port 8080.  You can change this"
	einfo " value by editing /opt/orion/config/default-web-site.xml."
	einfo
	einfo " To test Orion while it's running, point your web browser to:"
	einfo " http://localhost:8080/"
	einfo
	einfo
	einfo " APPLICATION DEPLOYMENT:"
	einfo " To set an administrative password, execute the following"
	einfo " commands as user 'orion':"
	einfo " \$ java -jar /usr/share/${PN}/lib/orion.jar -install"
	einfo
	einfo
	einfo " BUGS:"
	einfo " Please file any bugs at http://bugs.gentoo.org/ or else it"
	einfo " may not get seen.  Thank you."
	einfo
}
