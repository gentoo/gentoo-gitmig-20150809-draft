# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/tomcat/tomcat-5.0.18.ebuild,v 1.5 2004/03/21 09:12:32 mholzer Exp $

inherit eutils

DESCRIPTION="Apache Servlet-2.4/JSP-2.0 Container"
SRC_URI="http://apache.mirrors.pair.com/jakarta/tomcat-`echo ${PV} | cut -b 1`/v${PV}/bin/jakarta-${P}.tar.gz"
HOMEPAGE="http://jakarta.apache.org/tomcat"
KEYWORDS="x86 ppc sparc ~alpha"
LICENSE="Apache-1.1"
SLOT="0"
DEPEND="sys-apps/sed
		>=dev-java/java-config-1.2.6"
RDEPEND=">=virtual/jdk-1.2"
IUSE="doc jikes"

S=${WORKDIR}/jakarta-${P}
At="jakarta-tomcat-${PV}.tar.gz"

src_unpack() {
	tar xzf ${DISTDIR}/${At} || die
	cd ${S}
	epatch ${FILESDIR}/${PV}/gentoo.diff

	if [ ! `use doc` ] ; then
		rm -rf webapps/{tomcat-docs,jsp-examples,servlets-examples}
	fi
}


pkg_setup() {
	USERADDED=false
	if ! groupmod tomcat >/dev/null 2>&1 ; then
		groupadd -g 265 tomcat || die "problem adding group tomcat, gid 265"
		USERADDED=true
	fi
	if ! id tomcat >/dev/null 2>&1 ; then
		useradd -u 265 -g tomcat -s /bin/bash -d /opt/tomcat -c "Apache Tomcat" tomcat || die "problem adding user tomcat, uid 265"
		USERADDED=true
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

	keepdir /var/log/${PN}
	keepdir ${TOMCAT_HOME}/temp
	keepdir ${TOMCAT_HOME}/work

	cd ${S}

	# INIT SCRIPTS AND ENV

	cp -a ${FILESDIR}/${PV}/tomcat.init ${S}/tomcat
	insinto /etc/init.d
	insopts -m0750
	doins ${S}/tomcat

	cp -a ${FILESDIR}/${PV}/tomcat.conf ${S}/tomcat
	use jikes && epatch ${FILESDIR}/${PV}/jikes.diff
	insinto /etc/conf.d
	insopts -m0644
	doins ${S}/tomcat

	cp -a ${FILESDIR}/${PV}/21tomcat ${S}/21tomcat
	insinto /etc/env.d
	insopts -m0644
	doins ${S}/21tomcat

	# SEND JARS TO SHARED LOCATION
	for i in \
		common/lib/*.jar
	do
		dojar ${i}
		rm ${i}
	done

	dodoc RELEASE-NOTES RUNNING.txt LICENSE

	chown -R tomcat:tomcat ${S}
	DIROPTIONS="--mode=0750 --owner=tomcat --group=tomcat"
	dodir ${TOMCAT_HOME}/common
	dodir ${TOMCAT_HOME}/common/classes
	dodir ${TOMCAT_HOME}/webapps

	rm bin/*.bat bin/*.exe

	cp -Rdp \
		bin \
		server \
		shared \
		webapps \
		work \
		${D}${TOMCAT_HOME}

	cp -Rdp common/endorsed ${D}${TOMCAT_HOME}/common/

	cp -Rdp conf ${D}/etc/tomcat
	fperms 640 /etc/tomcat/tomcat-users.xml

	dosym /usr/share/tomcat/package.env ${TOMCAT_HOME}/common/package.env
	dosym /usr/share/tomcat/lib ${TOMCAT_HOME}/common/lib
	dosym /etc/tomcat ${TOMCAT_HOME}/conf

}

pkg_postinst() {
	einfo " "
	einfo " NOTICE!"
	if ${USERADDED} ; then
		einfo " User and group 'tomcat' have been added."
		einfo " "
	fi
	einfo " FILE LOCATIONS:"
	einfo " 1.  Tomcat home directory: ${TOMCAT_HOME}"
	einfo "     Contains application data, configuration files."
	einfo " 2.  Runtime settings: /etc/conf.d/tomcat"
	einfo "     Contains CLASSPATH and JAVA_HOME settings."
	einfo " 3.  Configuration:  /etc/tomcat/"
	einfo " 4.  Logs:  /var/log/tomcat/"
	einfo " 5.  Executables, libraries:  /usr/share/tomcat/"
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
	einfo " value by editing /etc/tomcat/server.xml."
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

# pkg_postrm() gets called during an unmerge and seperately (new environment)
# from the src_install() earlier so setting the INSTALLING var does not work.
#pkg_postrm() {
#	if [ -z "${INSTALLING}" ] ; then
#		einfo ">>> Removing user for Tomcat"
#		userdel tomcat || die "Error removing Tomcat user"
#		einfo ">>> Removing group for Tomcat"
#		groupdel tomcat || die "Error removing Tomcat group"
#	else
#		einfo ">>> Tomcat user and group preserved"
#	fi
#}
