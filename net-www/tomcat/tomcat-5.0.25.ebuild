# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/tomcat/tomcat-5.0.25.ebuild,v 1.2 2004/06/25 01:14:15 agriffis Exp $

inherit eutils

DESCRIPTION="Apache Servlet-2.4/JSP-2.0 Container"

JT_P="jakarta-${P}.tar.gz"
S=${WORKDIR}/jakarta-${P}
SRC_URI="http://mirrors.combose.com/apache/jakarta/tomcat-5/v5.0.25-alpha/bin/${JT_P}"
HOMEPAGE="http://jakarta.apache.org/tomcat"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
LICENSE="Apache-2.0"
SLOT="0"
DEPEND="sys-apps/sed"
RDEPEND=">=virtual/jdk-1.2"
RESTRICT="nomirror"
IUSE=""

src_unpack() {
	tar xzf ${DISTDIR}/${JT_P} || die
	cd ${S}
	epatch ${FILESDIR}/${PV}/gentoo.diff
}

pkg_setup() {
	USERADDED=false
	if ! groupmod tomcat >/dev/null 2>&1 ; then
		groupadd -g 265 tomcat || die "problem adding group tomcat, gid 265"
		USERADDED=true
	fi

	if ! id tomcat >/dev/null 2>&1 ; then
		useradd -u 265 -g tomcat -s /bin/bash -d /opt/${PN}5 -c "Apache Tomcat" tomcat || die "problem adding user tomcat, uid 265"
		USERADDED=true
	fi
}

src_install() {
	TOMCAT_HOME="/opt/tomcat5"
	TOMCAT_NAME="tomcat5"
	INSTALLING="yes"
	DIROPTIONS="--mode=0750 --owner=tomcat --group=tomcat"

	# Create directories
	dodir ${TOMCAT_HOME}
	dodir /var/log/${TOMCAT_NAME}
	dosym /var/log/${TOMCAT_NAME} ${TOMCAT_HOME}/logs
	keepdir /var/log/${TOMCAT_NAME}

	cd ${S}

	# FIX ALL PERMISSIONS
	chown -R tomcat:tomcat ${S}

	cp -a * ${D}${TOMCAT_HOME}

	# INIT SCRIPTS AND ENV
	cp -a ${FILESDIR}/${PV}/tomcat.init ${S}/${TOMCAT_NAME}
	insinto /etc/init.d
	insopts -m0750
	doins ${S}/${TOMCAT_NAME}

	cp -a ${FILESDIR}/${PV}/tomcat.conf ${S}/${TOMCAT_NAME}
	insinto /etc/conf.d
	insopts -m0644
	doins ${S}/${TOMCAT_NAME}

	cp -a ${FILESDIR}/${PV}/21tomcat ${S}/21${TOMCAT_NAME}
	insinto /etc/env.d
	insopts -m0644
	doins ${S}/21${TOMCAT_NAME}

	dodir /etc/${TOMCAT_NAME}
	dosym /etc/${TOMCAT_NAME} ${TOMCAT_HOME}/conf
}

pkg_postinst() {
	einfo " "
	einfo " NOTICE!"
	if ${USERADDED} ; then
		einfo " User and group 'tomcat' have been added."
		einfo " "
	fi
	einfo " FILE LOCATIONS:"
	einfo " 1.  Tomcat home directory: /opt/tomcat5"
	einfo "     Contains application data, configuration files."
	einfo " 2.  Runtime settings: /etc/conf.d/tomcat5"
	einfo "     Contains CLASSPATH and JAVA_HOME settings."
	einfo " 3.  Configuration:  /etc/tomcat5/"
	einfo " 4.  Logs:  /var/log/tomcat5/"
	einfo " 5.  Executables, libraries:  /usr/share/tomcat/"
	einfo " "
	einfo " "
	einfo " STARTING AND STOPPING TOMCAT:"
	einfo "   /etc/init.d/tomcat5 start"
	einfo "   /etc/init.d/tomcat5 stop"
	einfo "   /etc/init.d/tomcat5 restart"
	einfo " "
	einfo " "
	einfo " NETWORK CONFIGURATION:"
	einfo " By default, Tomcat runs on port 8080.  You can change this"
	einfo " value by editing /etc/tomcat5/server.xml."
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
