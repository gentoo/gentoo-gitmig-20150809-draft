# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/orion/orion-2.0.1.ebuild,v 1.1 2003/05/01 17:50:29 absinthe Exp $

S=${WORKDIR}/${PN}

At=${PN}${PV}.zip
JAVA_HOME=`java-config --jdk-home`

DESCRIPTION="Orion EJB/J2EE application webserver"
SRC_URI="http://www.orionserver.com/distributions/${At}"
HOMEPAGE="http://www.orionserver.com/"
KEYWORDS="x86 ppc sparc"
LICENSE="ORIONSERVER"
SLOT="0"
DEPEND=">=virtual/jdk-1.3
	app-arch/unzip"

src_unpack() {
	unzip -q ${DISTDIR}/${At} || die
	cd ${S}
	epatch ${FILESDIR}/${PV}/${PV}-gentoo.patch
}

pkg_setup() {
	if ! groupmod orion ; then
		groupadd -g 260 orion || die "problem adding group orion"
	fi
	if ! id orion; then
		useradd -u 260 -g orion -s /bin/bash -d /opt/orion -c "orion" orion || die "problem adding user orion"
	fi
}

src_install() {
	
	# CREATE DIRECTORIES
	DIROPTIONS="--mode=0775 --owner=orion --group=orion"
	dodir /opt/${PN}
	dodir /opt/${PN}/config
	dodir /opt/${PN}/sbin
	dodir /var/log/${PN}

	cd ${S}

	# INSTALL STARTUP SCRIPTS
	insinto /opt/orion/sbin
	insopts -o orion -g orion -m0750
	doins ${FILESDIR}/${PV}/start_orion.sh
	doins ${FILESDIR}/${PV}/stop_orion.sh
	
	cp -a ${FILESDIR}/${PV}/orion.init ${S}/orion
	insinto /etc/init.d
	insopts -m0750
	doins ${S}/orion

	cp -a ${FILESDIR}/${PV}/orion.conf ${S}/orion
	insinto /etc/conf.d
	insopts -m0755
	doins ${S}/orion

	# CREATE DUMMY LOG & PERSISTENCE DIR
	insopts -o orion -g orion -m0750
	touch ${S}/.keep
	insinto /var/log/${PN}
	doins ${S}/.keep
	insinto /opt/${PN}/persistence
	doins ${S}/.keep

	# INSTALL EXTRA FILES
	local dirs="applications database default-web-app demo lib persistence autoupdate.properties"
	for i in $dirs ; do
		cp -a ${i} ${D}/opt/${PN}/
		chown -R orion.orion ${D}/opt/${PN}/${i}
	done
	
	# INSTALL APP CONFIG
	cd ${S}/config
	local dirs="application.xml data-sources.xml database-schemas default-web-site.xml global-web-application.xml jms.xml mime.types principals.xml rmi.xml server.xml"
	for i in $dirs ; do
		cp -a ${i} ${D}/opt/${PN}/config
		chown -R orion.orion ${D}/opt/${PN}/config/${i}
	done
	
	# INSTALL JARS
	cd ${S}
	for i in `ls *.jar` ; do
		dojar $i
	done
	
	# LINK IN SDK TOOLS.JAR
	ln -s ${JAVA_HOME}/lib/tools.jar ${D}/usr/share/${PN}/lib/tools.jar
	
	# INSTALL DOCS
	dodoc Readme.txt changes.txt
}

pkg_postinst() {
	einfo " "
	einfo " NOTICE!"
	einfo " User and group 'orion' have been added."
	einfo " Please set a password for the user account 'orion'"
	einfo " if you have not done so already."
	einfo " "
	einfo " "
	einfo " FILE LOCATIONS:"
	einfo " 1.  Orion home directory: /opt/orion"
	einfo "     Contains application data, configuration files."
	einfo " 2.  Runtime settings: /etc/conf.d/orion"
	einfo "     Contains CLASSPATH and JDK settings."
	einfo " 3.  Logs:  /var/log/orion/"
	einfo " 4.  Executables, libraries:  /usr/share/${PN}/"
	einfo " "
	einfo " "
	einfo " STARTING AND STOPPING ORION:"
	einfo "   /etc/init.d/orion start"
	einfo "   /etc/init.d/orion stop"
	einfo "   /etc/init.d/orion restart"
	einfo " "
	einfo " "
	einfo " NETWORK CONFIGURATION:"
	einfo " By default, Orion runs on port 8080.  You can change this"
	einfo " value by editing /opt/orion/config/default-web-site.xml."
	einfo " "
	einfo " To test Orion while it's running, point your web browser to:"
	einfo " http://localhost:8080/"
	einfo " "
	einfo " "
	einfo " APPLICATION DEPLOYMENT:"
	einfo " To set an administrative password, execute the following"
	einfo " commands as user 'orion':"
	einfo " \$ java -jar /usr/share/${PN}/lib/orion.jar -install"
	einfo " "
	einfo " "
	einfo " BUGS:"
	einfo " Please file any bugs at http://bugs.gentoo.org/ or else it"
	einfo " may not get seen.  Thank you."
	einfo " "
	echo -ne "\a" ; sleep 1 ; echo -ne "\a" ; sleep 1 ; echo -ne "\a" ; sleep 1
        sleep 10

}
