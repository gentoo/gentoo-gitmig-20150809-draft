# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/tomcat/tomcat-4.1.24-r1.ebuild,v 1.1 2003/05/27 04:36:16 absinthe Exp $

S=${WORKDIR}/jakarta-${P}
At="jakarta-tomcat-${PV}.tar.gz"
DESCRIPTION="Apache Servlet Engine"
SRC_URI="http://jakarta.apache.org/builds/jakarta-tomcat-4.0/release/v${PV}/bin/${At}"
HOMEPAGE="http://jakarta.apache.org/tomcat"
KEYWORDS="x86 ppc sparc ~alpha"
LICENSE="Apache-1.1"
SLOT="0"
DEPEND=">=virtual/jdk-1.2"
RDEPEND="sys-apps/sed"

src_unpack() {
	tar xzf ${DISTDIR}/${At} || die
	cd ${S}
	epatch ${FILESDIR}/${PV}/gentoo.diff
}


pkg_setup() {
	if ! groupmod tomcat ; then
		groupadd -g 265 tomcat || die "problem adding group tomcat, gid 265"
	fi
	if ! id tomcat; then
		useradd -u 265 -g tomcat -s /bin/bash -d /opt/tomcat -c "Apache Tomcat" tomcat || die "problem adding user tomcat, uid 265"
	fi
}

src_install() {
	TOMCAT_HOME="/opt/tomcat"
	INSTALLING="yes"
	DIROPTIONS="--mode=0750 --owner=tomcat --group=tomcat"
	
	# Create directories
	dodir ${TOMCAT_HOME}
	dodir /var/log/${PN}
	dosym /var/log/${PN} ${TOMCAT_HOME}/logs
	dodir ${TOMCAT_HOME}/temp
	dodir ${TOMCAT_HOME}/work

	touch ${D}${TOMCAT_HOME}/logs/.keep
	touch ${D}${TOMCAT_HOME}/temp/.keep
	touch ${D}${TOMCAT_HOME}/work/.keep

	cd ${S}

	# INIT SCRIPTS AND ENV
	
	cp -a ${FILESDIR}/${PV}/tomcat.init ${S}/tomcat
	insinto /etc/init.d
	insopts -m0750
	doins ${S}/tomcat

	cp -a ${FILESDIR}/${PV}/tomcat.conf ${S}/tomcat
	insinto /etc/conf.d
	insopts -m0750
	doins ${S}/tomcat
	
	cp -a ${FILESDIR}/${PV}/21tomcat ${S}/21tomcat
	insinto /etc/env.d
	insopts -m0750
	doins ${S}/21tomcat

	# SEND JARS TO SHARED LOCATION
	for i in \
		common/endorsed/*.jar \
		common/lib/*.jar
	do
		dojar ${i}
		rm ${i}
	done

	dodoc RELEASE-NOTES-* README.txt RUNNING.txt LICENSE RELEASE-PLAN-4.1.txt
	
	chown -R tomcat.tomcat ${S}
	DIROPTIONS="--mode=0750 --owner=tomcat --group=tomcat"
	dodir ${TOMCAT_HOME}/common
	dodir ${TOMCAT_HOME}/common/classes
	dodir ${TOMCAT_HOME}/webapps
	
	cp -Rdp \
		bin \
		conf \
		server \
		shared \
		webapps \
		work \
		${D}${TOMCAT_HOME}
	
	dosym /usr/share/tomcat/package.env ${TOMCAT_HOME}/common/package.env
	dosym /usr/share/tomcat/lib ${TOMCAT_HOME}/common/endorsed
	dosym /usr/share/tomcat/lib ${TOMCAT_HOME}/common/lib
	
}

pkg_postinst() {
	einfo " "
	einfo " NOTICE!"
	einfo " User and group 'tomcat' have been added."
	einfo " "
	einfo " FILE LOCATIONS:"
	einfo " 1.  Tomcat home directory: ${TOMCAT_HOME}"
	einfo "     Contains application data, configuration files."
	einfo " 2.  Runtime settings: /etc/conf.d/tomcat"
	einfo "     Contains CLASSPATH and JAVA_HOME settings."
	einfo " 3.  Logs:  /var/log/tomcat/"
	einfo " 4.  Executables, libraries:  /usr/share/tomcat/"
	einfo " "
	einfo " "
	einfo " STARTING AND STOPPING TOMCAT:"
	einfo "   /etc/init.d/tomcat start"
	einfo "   /etc/init.d/tomcat stop"
	einfo "   /etc/init.d/tomcat restart"
	einfo " "
	einfo " "
	einfo " NETWORK CONFIGURATION:"
	einfo " By default, Tomcat runs on port 8080.  You can change this"
	einfo " value by editing ${TOMCAT_HOME}/conf/server.xml."
	einfo " "
	einfo " To test Tomcat while it's running, point your web browser to:"
	einfo " http://localhost:8080/"
	einfo " "
	einfo " "
	einfo " BUGS:"
	einfo " Please file any bugs at http://bugs.gentoo.org/ or else it"
	einfo " may not get seen.  Thank you."
	einfo " "
	echo -ne "\a" ; sleep 1 ; echo -ne "\a" ; sleep 1 ; echo -ne "\a" ; sleep 1
        sleep 10

}

pkg_postrm() {
	if [ -z "${INSTALLING}" ] ; then
		einfo ">>> Removing user for Tomcat"
		userdel tomcat || die "Error removing Tomcat user"
		einfo ">>> Removing group for Tomcat"
		groupdel tomcat || die "Error removing Tomcat group"
	else
		einfo ">>> Tomcat user and group preserved"
	fi
}
