# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/tomcat/tomcat-5.0.28.ebuild,v 1.2 2004/11/17 16:58:29 corsair Exp $

inherit eutils java-pkg

DESCRIPTION="Apache Servlet-2.4/JSP-2.0 Container"

SRC_URI="mirror://apache/tomcat-${SLOT}/v${PV}/bin/jakarta-${P}-src.tar.gz"
HOMEPAGE="http://jakarta.apache.org/tomcat"
KEYWORDS="~x86 ~ppc64"
LICENSE="Apache-2.0"
SLOT="${PV/.*}"
DEPEND="sys-apps/sed
	   >=virtual/jdk-1.4
	   >=dev-java/commons-beanutils-1.7.0
	   >=dev-java/commons-collections-3.1
	   >=dev-java/commons-daemon-1.0
	   >=dev-java/commons-digester-1.5
	   >=dev-java/commons-logging-1.0.4
	   >=dev-java/commons-el-1.0
	   >=dev-java/regexp-1.3
	   >=dev-java/xerces-2.6.2-r1
	   >=dev-java/log4j-1.2.8
	   >=dev-java/commons-dbcp-1.2.1
	   >=dev-java/commons-httpclient-2.0
	   >=dev-java/commons-pool-1.2
	   >=dev-java/commons-fileupload-1.0
	   >=dev-java/commons-modeler-1.1
	   >=dev-java/commons-launcher-0.9
	   >=dev-java/junit-3.8.1
	   dev-java/jmx
	   =dev-java/struts-1.1-r2
	   >=dev-java/saxpath-1.0
	   >=dev-java/jaxen-1.0
	   jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jdk-1.4
		jikes? ( dev-java/jikes )"
IUSE="doc jikes"
S=${WORKDIR}/jakarta-${P}-src

TOMCAT_HOME="/opt/${PN}${SLOT}"
TOMCAT_NAME="${PN}${SLOT}"

src_unpack() {
	unpack ${A}

	mkdir ${T}/lib
	cd ${T}/lib
	java-pkg_jar-from commons-logging
	java-pkg_jar-from xerces-2
	java-pkg_jar-from struts
	java-pkg_jar-from saxpath
	java-pkg_jar-from jaxen
	java-pkg_jar-from jmx
	java-pkg_jar-from commons-beanutils

	cd ${S}

	# update the build.xml to remove downloading
	epatch ${FILESDIR}/${PV}/build.xml-01.patch
	epatch ${FILESDIR}/${PV}/build.xml-02.patch

	epatch ${FILESDIR}/${PV}/gentoo.diff
	use jikes && epatch ${FILESDIR}/${PV}/jikes.diff

}

src_compile(){
	local antflags="-Dbase.path=${T}"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	antflags="${antflags} -Dcommons-beanutils.jar=${T}/lib/commons-beanutils.jar"
	antflags="${antflags} -Dcommons-collections.jar=$(java-config -p commons-collections)"
	antflags="${antflags} -Dcommons-daemon.jar=$(java-config -p commons-daemon)"
	antflags="${antflags} -Dcommons-digester.jar=$(java-config -p commons-digester)"
	antflags="${antflags} -Dcommons-el.jar=$(java-config -p commons-el)"

	#
	# Work around for the fact that java-config is unable to return a
	# particular jar from a package.
	#
	antflags="${antflags} -Dcommons-logging.jar=${T}/lib/commons-logging.jar"
	antflags="${antflags} -Dcommons-logging-api.jar=${T}/lib/commons-logging-api.jar"
	antflags="${antflags} -Dregexp.jar=$(java-config -p regexp)"

	#
	# Same work around again
	#
	antflags="${antflags} -DxercesImpl.jar=${T}/lib/xercesImpl.jar"
	antflags="${antflags} -Dxml-apis.jar=${T}/lib/xml-apis.jar"
	antflags="${antflags} -Dlog4j.jar=$(java-config -p log4j)"
	antflags="${antflags} -Dcommons-dbcp.jar=$(java-config -p commons-dbcp)"
	antflags="${antflags} -Dcommons-httpclient.jar=$(java-config -p commons-httpclient)"
	antflags="${antflags} -Dcommons-pool.jar=$(java-config -p commons-pool)"
	antflags="${antflags} -Dcommons-fileupload.jar=$(java-config -p commons-fileupload)"
	antflags="${antflags} -Djunit.jar=$(java-config -p junit)"
	antflags="${antflags} -Dstruts.jar=${T}/lib/struts.jar"

	antflags="${antflags} -Djmx.jar=${T}/lib/jmxri.jar"
	antflags="${antflags} -Djmx-tools.jar=${T}/lib/jmxtools.jar"
	antflags="${antflags} -Dcommons-launcher.jar=$(java-config -p commons-launcher)"
	#`
	# This is used to reference the tld files in /usr/share/struts/lib
	#
	antflags="${antflags} -Dstruts.home=/usr/share/struts"
	antflags="${antflags} -Dcommons-modeler.jar=$(java-config -p commons-modeler)"
	antflags="${antflags} -Dstruts.jar=${T}/lib/struts.jar"
	antflags="${antflags} -Djaxen.jar=${T}/lib/jaxen-full.jar"
	antflags="${antflags} -Dsaxpath.jar=${T}/lib/saxpath.jar"

	ant ${antflags} || die "compile failed"

}
src_install() {
	cd ${S}/jakarta-tomcat-5/build

	# INIT SCRIPTS AND ENV
	insinto /etc/init.d
	insopts -m0750
	newins ${FILESDIR}/${PV}/tomcat.init ${TOMCAT_NAME}

	insinto /etc/conf.d
	insopts -m0644
	newins ${FILESDIR}/${PV}/tomcat.conf ${TOMCAT_NAME}
	use jikes && sed -e "\cCATALINA_OPTScaCATALINA_OPTS=\"-Dbuild.compiler.emacs=true\"" -i ${D}/etc/conf.d/${TOMCAT_NAME}

	diropts -m750
	dodir ${TOMCAT_HOME} /var/log/${TOMCAT_NAME} /etc/${TOMCAT_NAME}
	keepdir /var/log/${TOMCAT_NAME}

	mv conf/* ${D}/etc/${TOMCAT_NAME} || die "failed to move conf"
	mv bin common server shared temp work ${D}${TOMCAT_HOME} || die "failed to move"
	keepdir ${TOMCAT_HOME}/{work,temp}

	if ! use doc; then
	    rm -rf webapps/{tomcat-docs,jsp-examples,servlets-examples}
	fi

	mv webapps ${D}${TOMCAT_HOME}

	dosym /etc/${TOMCAT_NAME} ${TOMCAT_HOME}/conf
	dosym /var/log/${TOMCAT_NAME} ${TOMCAT_HOME}/logs

	fperms 640 /etc/${TOMCAT_NAME}/tomcat-users.xml
}


pkg_preinst() {
	enewgroup tomcat
	enewuser tomcat -1 -1 /dev/null tomcat

	chown -R tomcat:tomcat ${D}/opt/${TOMCAT_NAME}
	chown -R tomcat:tomcat ${D}/etc/${TOMCAT_NAME}
	chown -R tomcat:tomcat ${D}/var/log/${TOMCAT_NAME}
}

pkg_postinst() {
	#due to previous ebuild bloopers, make sure everything is correct
	use doc && chown -R root:root /usr/share/doc/${PF}
	chown root:root /etc/init.d/${TOMCAT_NAME}
	chown root:root /etc/conf.d/${TOMCAT_NAME}

	chown -R tomcat:tomcat /opt/${TOMCAT_NAME}
	chown -R tomcat:tomcat /etc/${TOMCAT_NAME}
	chown -R tomcat:tomcat /var/log/${TOMCAT_NAME}

	chmod 750 /etc/${TOMCAT_NAME}

	einfo " "
	einfo " NOTICE!"
	einfo " FILE LOCATIONS:"
	einfo " 1.  Tomcat home directory: ${TOMCAT_HOME}"
	einfo "     Contains application data, configuration files."
	einfo " 2.  Runtime settings: /etc/conf.d/${TOMCAT_NAME}"
	einfo "     Contains CLASSPATH and JAVA_HOME settings."
	einfo " 3.  Configuration:  /etc/${TOMCAT_NAME}"
	einfo " 4.  Logs:  /var/log/${TOMCAT_NAME}/"
	einfo " "
	einfo " "
	einfo " STARTING AND STOPPING TOMCAT:"
	einfo "   /etc/init.d/${TOMCAT_NAME} start"
	einfo "   /etc/init.d/${TOMCAT_NAME} stop"
	einfo "   /etc/init.d/${TOMCAT_NAME} restart"
	einfo " "
	einfo " "
	ewarn " If you are upgrading from older ebuild do NOT use"
	ewarn " /etc/init.d/tomcat and /etc/conf.d/tomcat you probably"
	ewarn " want to remove these. "
	ewarn " A version number has been appended so that tomcat 3, 4 and 5"
	ewarn " can be installed side by side"
	einfo " "
	einfo " NETWORK CONFIGURATION:"
	einfo " By default, Tomcat runs on port 8080.  You can change this"
	einfo " value by editing /etc/${TOMCAT_NAME}/server.xml."
	einfo " "
	einfo " To test Tomcat while it's running, point your web browser to:"
	einfo " http://localhost:8080/"
	! use doc && einfo " You do not have the doc USE flag set, examples have NOT been installed."
	einfo " "
	einfo " "
	einfo " BUGS:"
	einfo " Please file any bugs at http://bugs.gentoo.org/ or else it"
	einfo " may not get seen.  Thank you."
	einfo " "
}
