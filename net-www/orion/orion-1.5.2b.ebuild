# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/orion/orion-1.5.2b.ebuild,v 1.1 2003/03/11 11:54:15 absinthe Exp $

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
	
	insinto /etc/init.d
	insopts -o orion -g orion -m0750
	doins ${FILESDIR}/${PV}/orion.init
	
	insinto /etc/conf.d
	insopts -o orion -g orion -m0750
	doins ${FILESDIR}/${PV}/orion.conf

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
	einfo " "
        einfo " To set an administrative password, execute the"
	einfo " following commands as user 'orion':"
	einfo " \$ java -jar /usr/share/${PN}/lib/orion.jar -install"
        einfo " "
        einfo " "
	einfo " To start/stop orion, use '/etc/init.d/orion' as root."
	einfo " "
	einfo " "
	einfo " To test Orion while it's running, point your web"
	einfo " browser to:  http://localhost:8080/"
	einfo " "
	einfo " "
	echo -ne "\a" ; sleep 1 ; echo -ne "\a" ; sleep 1 ; echo -ne "\a" ; sleep 1
        sleep 10

}

