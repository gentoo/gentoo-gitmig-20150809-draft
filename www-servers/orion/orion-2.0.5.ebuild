# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/orion/orion-2.0.5.ebuild,v 1.10 2007/03/10 15:14:58 vapier Exp $

inherit eutils java-pkg

DESCRIPTION="Orion EJB/J2EE application webserver"
HOMEPAGE="http://www.orionserver.com/"
SRC_URI="http://www.orionserver.com/distributions/${PN}${PV}.zip"

LICENSE="ORIONSERVER"
KEYWORDS="~amd64 ~ppc x86"
SLOT="0"
IUSE=""

DEPEND=">=virtual/jdk-1.3
	app-arch/unzip"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PV}/${PV}-gentoo.patch
}

src_install() {
	# CREATE DIRECTORIES
	diropts -m0755
	dodir /opt/${PN}
	dodir /opt/${PN}/config
	dodir /opt/${PN}/sbin
	dodir /var/log/${PN}

	cd "${S}"

	# INSTALL STARTUP SCRIPTS
	insinto /opt/orion/sbin
	insopts -m0750
	doins "${FILESDIR}"/${PV}/start_orion.sh || die
	doins "${FILESDIR}"/${PV}/stop_orion.sh || die

	newinitd "${FILESDIR}"/${PV}/orion.init orion
	newconfd "${FILESDIR}"/${PV}/orion.conf orion

	# CREATE DUMMY LOG & PERSISTENCE DIR
	dodir /var/log/${PN}
	dodir /opt/${PN}/persistence

	keepdir /var/log/${PN}
	keepdir /opt/${PN}/persistence

	# INSTALL EXTRA FILES
	local dirs="applications default-web-app demo lib persistence autoupdate.properties"
	for i in $dirs ; do
		cp -pPR ${i} "${D}"/opt/${PN}/ || die "install ${i} failed"
	done

	# INSTALL APP CONFIG
	cd "${S}"/config
	local dirs="application.xml data-sources.xml database-schemas default-web-site.xml global-web-application.xml jms.xml mime.types principals.xml rmi.xml server.xml"
	for i in $dirs ; do
		cp -pPR ${i} "${D}"/opt/${PN}/config || die "install ${i} failed"
	done

	# INSTALL JARS
	cd "${S}"
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
	chown -R orion:orion "${D}"/opt/${PN}
	chown -R orion:orion "${D}"/var/log/${PN}
	chown root:0 "${D}"/etc/conf.d/orion
}

pkg_postinst() {
	einfo
	einfo " NOTICE!"
	einfo " User and group 'orion' have been added."
	einfo " Please set a password for the user account 'orion'"
	einfo " if you have not done so already."
	einfo
	einfo
	elog " FILE LOCATIONS:"
	elog " 1.  Orion home directory: /opt/orion"
	elog "     Contains application data, configuration files."
	elog " 2.  Runtime settings: /etc/conf.d/orion"
	elog "     Contains CLASSPATH and JDK settings."
	elog " 3.  Logs:  /var/log/orion/"
	elog " 4.  Executables, libraries:  /usr/share/${PN}/"
	elog
	elog
	elog " STARTING AND STOPPING ORION:"
	elog "   /etc/init.d/orion start"
	elog "   /etc/init.d/orion stop"
	elog "   /etc/init.d/orion restart"
	elog
	elog
	elog " NETWORK CONFIGURATION:"
	elog " By default, Orion runs on port 8080.  You can change this"
	elog " value by editing /opt/orion/config/default-web-site.xml."
	elog
	elog " To test Orion while it's running, point your web browser to:"
	elog " http://localhost:8080/"
	elog
	elog
	elog " APPLICATION DEPLOYMENT:"
	elog " To set an administrative password, execute the following"
	elog " commands as user 'orion':"
	elog " \$ java -jar /usr/share/${PN}/lib/orion.jar -install"
	elog
	elog
	elog " BUGS:"
	elog " Please file any bugs at http://bugs.gentoo.org/ or else it"
	elog " may not get seen.  Thank you."
	elog
}
