# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/orion/orion-1.5.2b-r1.ebuild,v 1.1 2003/03/13 22:27:40 absinthe Exp $

S=${WORKDIR}/${PN}

At=${PN}${PV}.zip
JAVA_HOME=`java-config --jdk-home`

DESCRIPTION="Orion EJB/J2EE application webserver"
SRC_URI=""
HOMEPAGE="http://www.orionserver.com/"
KEYWORDS="~x86"
LICENSE="ORIONSERVER"
SLOT="0"
DEPEND=">=virtual/jdk-1.3
	app-arch/unzip"

src_unpack() {
	if [ ! -f ${DISTDIR}/${At} ] ; then
		die "Please download ${At} from ${HOMEPAGE} and place into ${DISTDIR}."
	fi
	unzip -q ${DISTDIR}/${At} || die
	cd ${S}
	patch -p0 < ${FILESDIR}/${PV}/${PV}-gentoo.patch
}


pkg_setup() {

	if ! groupmod orion ; then
		groupadd -g 260 orion || die "problem adding group orion"
        fi

        if ! id orion; then
                useradd -g orion -s /bin/bash -d /opt/orion -c "orion" orion
                assert "problem adding user orion"
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
	touch ${S}/stdout.log
	touch ${S}/dummy
	insinto /var/log/${PN}
	insopts -o orion -g orion
	doins ${S}/stdout.log
	insinto /opt/${PN}/persistence
	doins ${S}/dummy

	# INSTALL EXTRA FILES
	local dirs="applications database default-web-app demo lib persistence autoupdate.properties"
        for i in $dirs ; do
		cp -a $i ${D}/opt/${PN}/
	done
	
	# INSTALL APP CONFIG
	cd ${S}/config
	local dirs="application.xml data-sources.xml database-schemas default-web-site.xml global-web-application.xml jms.xml mime.types principals.xml rmi.xml server.xml"
        for i in $dirs ; do
		cp -a $i ${D}/opt/${PN}/config
        done
	
	# INSTALL JARS
	cd ${S}
	for i in `ls *.jar` ; do
		dojar $i
	done
	
	# LINK IN SDK TOOLS.JAR
	ln -s ${JAVA_HOME}/lib/tools.jar ${D}/usr/share/${PN}/lib/tools.jar
	
	# INSTALL DOCS
	dodoc Copyright.txt Readme.txt changes.txt
}

pkg_postinst() {
	einfo " "
	einfo " NOTICE!  User account created:  orion"
	einfo " Please set a password for this account!"
	einfo " "
	einfo " Orion's home directory is: /opt/orion"
	einfo " In this directory you will have all of your application data,"
	einfo " settings and configurations."
	einfo " "
	einfo " Runtime settings, such as CLASSPATH and desired JDK are set"
	einfo " in /etc/conf.d/orion"
	einfo " "
	einfo " Logs can be found in /var/log/orion/"
	einfo " "
	einfo " Executables and libraries are in /usr/share/${PN}/"
	einfo " "
	einfo " To set an administrative password, execute the following"
	einfo " commands as user 'orion':"
	einfo " \$ java -jar /usr/share/${PN}/lib/orion.jar -install"
	einfo " "
	einfo " To start/stop orion, use '/etc/init.d/orion' as root."
	einfo " "
	einfo " By default, Orion runs on port 8080.  You can change this"
	einfo " value by editing /opt/orion/config/default-web-site.xml."
	einfo " "
	einfo " To test Orion while it's running, point your web browser to:"
	einfo " http://localhost:8080/"
	einfo " "
	echo -ne "\a" ; sleep 1 ; echo -ne "\a" ; sleep 1 ; echo -ne "\a" ; sleep 1
        sleep 10

}

