# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/tomcat/tomcat-6.0.7_alpha-r3.ebuild,v 1.1 2007/01/05 03:45:33 wltjr Exp $

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Apache Servlet-2.5/JSP-2.1 Container"

MY_P="apache-${P/_alpha/}-src"
SLOT="6"
SRC_URI="mirror://apache/${PN}/${PN}-6/v${PV/_/-}/src/${MY_P}.tar.gz"
HOMEPAGE="http://tomcat.apache.org/"
KEYWORDS="~amd64 ~x86"
LICENSE="Apache-2.0"

IUSE="doc examples jni source test"

RDEPEND="|| ( >=virtual/jre-1.5 >=virtual/jre-1.6 )
	=dev-java/eclipse-ecj-3.2*
	>=dev-java/commons-daemon-1.0.1
	>=dev-java/commons-dbcp-1.2.1
	>=dev-java/commons-logging-1.1
	>=dev-java/commons-pool-1.2
	jni? ( dev-java/tomcat-native )"

DEPEND="|| ( >=virtual/jdk-1.5 >=virtual/jdk-1.6 )
	${RDEPEND}
	test? (
		dev-java/junit
		dev-java/ant
	)
	!test? ( dev-java/ant-core )"

S=${WORKDIR}/${MY_P}
NS=${WORKDIR}/tomcat-native-${TC_NV}-src

TOMCAT_NAME="${PN}-${SLOT}"
TOMCAT_HOME="/usr/share/${TOMCAT_NAME}"
WEBAPPS_DIR="/var/lib/${TOMCAT_NAME}/webapps"

pkg_setup() {
	enewgroup tomcat 265
	enewuser tomcat 265 -1 /dev/null tomcat

	JAVA_PKG_WANT_SOURCE="1.5"
	JAVA_PKG_WANT_TARGET="1.5"
}

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch "${FILESDIR}/${SLOT}/build-xml.patch"

	cd ${S}/bin
	java-pkg_jar-from commons-daemon
}

src_compile(){
	# Prevent out of memory/heap space errors
	java-pkg_force-compiler ecj-3.2

	local antflags="build-jasper-jdt build-only -Dbase.path=${T}"
	antflags="${antflags} -Dant.jar=$(java-pkg_getjar ant-core ant.jar)"
	antflags="${antflags} -Dcommons-daemon.jar=$(java-pkg_getjar commons-daemon commons-daemon.jar)"
	antflags="${antflags} -Djdt.jar=$(java-pkg_getjar eclipse-ecj-3.2 ecj.jar)"
	eant ${antflags}
}

src_install() {
	local CATALINA_BASE=/var/lib/${TOMCAT_NAME}/

	# init.d, conf.d
	newinitd ${FILESDIR}/${SLOT}/tomcat.init ${TOMCAT_NAME}
	newconfd ${FILESDIR}/${SLOT}/tomcat.conf ${TOMCAT_NAME}

	# create dir structure
	diropts -m755 -o tomcat -g tomcat
	dodir   /etc/${TOMCAT_NAME}
	fperms  750 /etc/${TOMCAT_NAME}
	dodir /usr/share/${TOMCAT_NAME}
	keepdir /var/log/${TOMCAT_NAME}/
	keepdir /var/tmp/${TOMCAT_NAME}/
	keepdir /var/run/${TOMCAT_NAME}/
	dodir   ${CATALINA_BASE}
	diropts -m0755

	cd ${S}
	# we don't need dos scripts
	rm -f bin/*.bat
	chmod 755 bin/*.sh

	# fix context's since upstream is slackin
	sed -i -e 's:}/server/:}/:' ${S}/webapps/host-manager/host-manager.xml
	sed -i -e 's:}/server/:}/:' ${S}/webapps/manager/manager.xml

	# copy the manager's context to the right position
	mkdir -p conf/Catalina/localhost
	cp ${S}/webapps/host-manager/host-manager.xml conf/Catalina/localhost
	cp ${S}/webapps/manager/manager.xml conf/Catalina/localhost

	# replace the default pw with a random one, see #92281
	local randpw=$(echo ${RANDOM}|md5sum|cut -c 1-15)
	sed -e s:SHUTDOWN:${randpw}: -i conf/server.xml

	# copy over the directories
	chown -R tomcat:tomcat webapps/* conf/*
	cp -pR conf/* ${D}/etc/${TOMCAT_NAME} || die "failed to copy conf"
	cp -R bin output/build/bin output/build/lib ${D}/usr/share/${TOMCAT_NAME} \
		|| die "failed to copy"

	cp ${T}/tomcat6-deps/jdt/jasper-jdt.jar ${D}/usr/share/${TOMCAT_NAME}/lib \
		|| die "failed to copy"

	keepdir               ${WEBAPPS_DIR}
	chown  tomcat:tomcat ${D}/${WEBAPPS_DIR} || die "Failed to change owner off ${1}."
	chmod  750           ${D}/${WEBAPPS_DIR} || die "Failed to change permissions off ${1}."

	cd ${S}

	# Copy over webapps, some controlled by use flags
	cp -p RELEASE-NOTES webapps/ROOT/RELEASE-NOTES.txt
	cp -pr webapps/ROOT ${D}${CATALINA_BASE}/webapps

	mkdir ${D}${TOMCAT_HOME}/webapps
	chown tomcat:tomcat ${D}${TOMCAT_HOME}/webapps
	cp -pr webapps/host-manager ${D}${TOMCAT_HOME}/webapps
	cp -pr webapps/manager ${D}${TOMCAT_HOME}/webapps

	if use doc; then
		cp -pr webapps/docs ${D}${CATALINA_BASE}/webapps
	fi
	if use examples; then
		cp -pr webapps/examples \
			${D}${CATALINA_BASE}/webapps
	fi

	# symlink the directories to make CATALINA_BASE possible
	dosym /etc/${TOMCAT_NAME} ${CATALINA_BASE}/conf
	dosym /var/log/${TOMCAT_NAME} ${CATALINA_BASE}/logs
	dosym /var/tmp/${TOMCAT_NAME} ${CATALINA_BASE}/temp
	dosym /var/run/${TOMCAT_NAME} ${CATALINA_BASE}/work

	dodoc  ${S}/{RELEASE-NOTES,RUNNING.txt}
	fperms 640 /etc/${TOMCAT_NAME}/tomcat-users.xml
}

pkg_postinst() {
	einfo
	einfo " This ebuild implements a FHS compliant layout for tomcat"
	einfo " Please read http://www.gentoo.org/proj/en/java/tomcat-guide.xml"
	einfo " for more information."
	einfo
	einfo " Please report any bugs to http://bugs.gentoo.org/"
	einfo
}
