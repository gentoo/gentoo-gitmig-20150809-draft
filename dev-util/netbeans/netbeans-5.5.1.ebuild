# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/netbeans/netbeans-5.5.1.ebuild,v 1.2 2007/08/25 22:57:33 mr_bones_ Exp $

inherit eutils java-pkg-2 java-ant-2 versionator

DESCRIPTION="NetBeans IDE for Java"
HOMEPAGE="http://www.netbeans.org"

MY_PV=$(replace_all_version_separators '_')

FILE_IDE="${PN}-${MY_PV}-ide_sources.tar.bz2"
FILE_CPP="${PN}-c++-${MY_PV}-linux.bin"
SRC_URI="http://dlc.sun.com/${PN}/download/${MY_PV}/fcs/200704122300/${FILE_IDE}
	c++? ( http://dlc.sun.com/${PN}/download/${MY_PV}/cnd/mlfcs/070610/${FILE_CPP} )"
LICENSE="CDDL"
SLOT="5.5"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE="c++ debug doc"

COMMON_DEPEND="
	>=dev-java/ant-1.7.0
	>=dev-java/ant-tasks-1.7.0-r2
	>=dev-java/commons-logging-1.0.4
	dev-java/flute
	>=dev-java/jakarta-jstl-1.1.2
	>=dev-java/jgoodies-forms-1.0.5
	>=dev-java/jmi-interface-1.0-r3
	>=dev-java/javahelp-2.0.02
	>=dev-java/jsch-0.1.24
	=dev-java/junit-3.8*
	dev-java/sac
	=dev-java/servletapi-2.2*
	>=dev-java/sun-j2ee-deployment-bin-1.1
	=dev-java/swing-layout-1*
	>=dev-java/xerces-2.8.0
	>=dev-java/xml-commons-1.0_beta2"

RDEPEND=">=virtual/jre-1.5
	dev-java/antlr
	=dev-java/commons-beanutils-1.7*
	dev-java/commons-collections
	dev-java/commons-digester
	>=dev-java/commons-fileupload-1.1
	>=dev-java/commons-io-1.2
	dev-java/commons-validator
	dev-java/fastinfoset
	dev-java/jakarta-oro
	dev-java/jax-rpc
	dev-java/jax-ws
	dev-java/jax-ws-api
	>=dev-java/jaxb-2
	>=dev-java/jaxb-tools-2
	dev-java/jaxp
	dev-java/jsr67
	dev-java/jsr101
	dev-java/jsr173
	dev-java/jsr181
	dev-java/jsr250
	dev-java/relaxng-datatype
	dev-java/saaj
	dev-java/sjsxp
	=dev-java/struts-1.2*
	dev-java/sun-httpserver-bin
	dev-java/sun-jaf
	dev-java/sun-javamail
	dev-java/xsdlib
	${COMMON_DEPEND}"

# NOTE: netbeans cannot compile with latest JDK 1.7
DEPEND="|| ( =virtual/jdk-1.6* =virtual/jdk-1.5* )
	dev-java/commons-el
	>=dev-java/commons-jxpath-1.1
	dev-java/glassfish-persistence
	dev-java/ical4j
	>=dev-java/jcalendar-1.2
	>=dev-java/jdom-1.0
	dev-java/jtidy
	>=dev-java/prefuse-20060715_beta
	>=dev-java/rome-0.6
	=dev-java/servletapi-2.3*
	=dev-java/xml-xmlbeans-1*
	>=dev-util/pmd-1.3
	${COMMON_DEPEND}"

S=${WORKDIR}/netbeans-src
BUILDDESTINATION="${S}/nbbuild/netbeans"
ENTERPRISE="3"
IDE_VERSION="7"
PLATFORM="6"
MY_FDIR="${FILESDIR}/${PV}"
DESTINATION="/usr/share/netbeans-${SLOT}"
JAVA_PKG_BSFIX="off"

src_unpack () {
	unpack "${FILE_IDE}"
	use c++ && unpack_extra ${FILE_CPP} cpp
	cd ${S}
	find -name "*.jar" | grep "/test/" | xargs rm -v
	find -name "*.class" -delete

	# Correct invalid XML
	epatch "${MY_FDIR}/jdbcstorage-build.xml-comments.patch"
	epatch "${MY_FDIR}/mdrant-build.xml-comments.patch"
	epatch "${MY_FDIR}/jspparser-build.xml.patch"

	# Disable the bundled Tomcat in favor of Portage installed version
	cd ${S}/nbbuild
	sed -i -e "s%tomcatint/tomcat5/bundled,%%g" *.properties

	place_unpack_symlinks
}

src_compile() {
	local antflags=""

	if use debug; then
		antflags="${antflags} -Dbuild.compiler.debug=true"
		antflags="${antflags} -Dbuild.compiler.deprecation=true"
	else
		antflags="${antflags} -Dbuild.compiler.deprecation=false"
	fi

	# The build will attempt to display graphical
	# dialogs for the licence agreements if this is set.
	unset DISPLAY

	# Fails to compile
	java-pkg_filter-compiler ecj-3.1 ecj-3.2

	# Specify the build-nozip target otherwise it will build
	# a zip file of the netbeans folder, which will copy directly.
	cd ${S}/nbbuild
	ANT_OPTS="-Xmx1g -Djava.awt.headless=true" eant ${antflags} -Dstop.when.broken.modules=true \
		build-nozip
	# Running build-javadoc from the same command line as build-nozip doesn't work
	# so we must run it separately
	use doc && ANT_OPTS="-Xmx1g" eant build-javadoc

	# Remove non-x86 Linux binaries
	find ${BUILDDESTINATION} -type f \
		-name "*.exe" -o \
		-name "*.cmd" -o \
		-name "*.bat" -o \
		-name "*.dll" \
		| xargs rm -f

	# Removing external stuff. They are api docs from external libs.
	rm -f ${BUILDDESTINATION}/ide${IDE_VERSION}/docs/*.zip

	# Remove zip files from generated javadocs.
	rm -f ${BUILDDESTINATION}/javadoc/*.zip

	# Use the system ant
	cd ${BUILDDESTINATION}/ide${IDE_VERSION}/ant || die
	rm -fr lib
	rm -fr bin

	# Set a initial default jdk
	echo "netbeans_jdkhome=\"\$(java-config -O)\"" >> ${BUILDDESTINATION}/etc/netbeans.conf

	# fix paths per bug# 163483
	sed -i -e 's:"$progdir"/../etc/:/etc/netbeans-5.5/:' ${BUILDDESTINATION}/bin/netbeans
	sed -i -e 's:"${userdir}"/etc/:/etc/netbeans-5.5/:' ${BUILDDESTINATION}/bin/netbeans
}

src_install() {
	insinto ${DESTINATION}

	einfo "Installing the program..."
	cd ${BUILDDESTINATION} || die
	doins -r *

	if use c++ ; then
		install_extra cpp
		echo "cnd1" >> ${BUILDDESTINATION}/etc/netbeans.clusters
	fi

	# Change location of etc files
	insinto /etc/${PN}-${SLOT}
	doins ${BUILDDESTINATION}/etc/*
	rm -fr ${D}/${DESTINATION}/etc
	dosym /etc/${PN}-${SLOT} ${DESTINATION}/etc

	# Replace bundled jars with system jars
	symlink_extjars ${D}/${DESTINATION}

	# Correct permissions on executables
	fperms 755 \
		${DESTINATION}/bin/netbeans \
		${DESTINATION}/platform${PLATFORM}/lib/nbexec

	# The wrapper wrapper :)
	newbin ${MY_FDIR}/startscript.sh netbeans-${SLOT}

	# Ant installation
	local ANTDIR="${DESTINATION}/ide${IDE_VERSION}/ant"
	cd ${D}/${ANTDIR} || die

	local ant_home=/usr/share/ant
	dodir ${ant_home}/lib
	dosym ${ant_home}/lib "${ANTDIR}/lib" || die

	dodir ${ant_home}/bin
	dosym ${ant_home}/bin  "${ANTDIR}/bin" || die

	# Documentation
	einfo "Installing Documentation..."

	cd ${D}/${DESTINATION} || die
	dodoc build_info
	dohtml CREDITS.html README.html netbeans.css
	rm -f build_info CREDITS.html README.html netbeans.css

	use doc && java-pkg_dojavadoc ${S}/nbbuild/build/javadoc

	# Icons and shortcuts
	einfo "Installing icon..."
	dodir /usr/share/icons/hicolor/32x32/apps
	dosym ${DESTINATION}/nb5.5/netbeans.png /usr/share/icons/hicolor/32x32/apps/netbeans-${SLOT}.png

	make_desktop_entry netbeans-${SLOT} "Netbeans ${SLOT}" netbeans-${SLOT}.png Development
}

pkg_postinst () {
	elog "The integrated Tomcat is not installed, but you can easily "
	elog "use the system Tomcat. See Netbeans documentation if you   "
	elog "don't know how to do that. The relevant settings are in the"
	elog "runtime window.                                            "
	elog
	elog "If you are using some packages on top of Netbeans, you have"
	elog "to re-emerge them now.                                     "
}

pkg_postrm() {
	if ! test -e /usr/bin/netbeans-${SLOT}; then
		elog "Because of the way Portage works at the moment"
		elog "symlinks to the system jars are left to:"
		elog "${DESTINATION}"
		elog "If you are uninstalling Netbeans you can safely"
		elog "remove everything in this directory"
	fi
}

# Supporting functions for this ebuild

unpack_extra() {
	local file="${1}"
	local cluster="${2}"

	einfo "Unpacking ${file}..."
	cp "${DISTDIR}/${file}" ${T}
	chmod u+x ${T}/${file}
	local dir="istemp`sh ${T}/${file} -is:tempdir ${WORKDIR} -is:extract | \
		sed s,istemp,\|,g | cut --delimiter=\| --field=2`" || die "Unpack ${file} failed"
	rm ${T}/${file}
	mv "${WORKDIR}/${dir}" "${WORKDIR}/${cluster}"
}

install_extra() {
	local cluster="${1}"

	einfo "Installing ${cluster}..."
	java "-Duser.home=${T}" -cp "${WORKDIR}/${cluster}/setup.jar" run \
		-silent \
		-W "license.selection=1" \
		-W "beanNbSelectionPanel.nbHome=${D}/${DESTINATION}" || \
		die "Install ${cluster} failed"
}

place_unpack_symlinks() {
	# Here are listed all bundled jars, some of them cannot be replaced.

	einfo "Symlinking jars for apisupport"
	cd ${S}/apisupport/external || die
	java-pkg_jar-from --build-only jdom-1.0
	java-pkg_jar-from javahelp jhall.jar jsearch-2.0_03.jar
	java-pkg_jar-from --build-only rome rome.jar rome-fetcher-0.6.jar
	java-pkg_jar-from --build-only rome rome.jar rome-0.6.jar

	einfo "Symlinking jars for core"
	cd ${S}/core/external || die
	java-pkg_jar-from javahelp jh.jar jh-2.0_03.jar

	einfo "Symlinking jars for httpserver"
	cd ${S}/httpserver/external || die
	java-pkg_jar-from servletapi-2.2 servlet.jar servlet-2.2.jar

	einfo "Symlinking jars for junit"
	cd ${S}/junit/external || die
	java-pkg_jar-from junit junit.jar junit-3.8.1.jar

	einfo "Symlinking jars for j2ee"
	cd ${S}/j2ee/external || die
	java-pkg_jar-from --build-only glassfish-persistence

	einfo "Symlinking jars for j2eeserver"
	cd ${S}/j2eeserver/external || die
	java-pkg_jar-from sun-j2ee-deployment-bin-1.1 sun-j2ee-deployment-bin.jar jsr88javax.jar

	einfo "Symlinking jars for libs"
	cd ${S}/libs/external || die
	java-pkg_jar-from commons-logging commons-logging.jar commons-logging-1.0.4.jar
	java-pkg_jar-from jgoodies-forms forms.jar forms-1.0.5.jar
	java-pkg_jar-from jsch jsch.jar jsch-0.1.24.jar
	java-pkg_jar-from --build-only pmd pmd.jar pmd-1.3.jar
	java-pkg_jar-from swing-layout-1 swing-layout.jar swing-layout-1.0.jar
	java-pkg_jar-from --build-only xml-xmlbeans-1 xbean.jar xbean-1.0.4.jar
	java-pkg_jar-from xerces-2 xercesImpl.jar xerces-2.8.0.jar
	java-pkg_jar-from xml-commons xml-apis.jar xml-commons-dom-ranges-1.0.b2.jar

	einfo "Symlinking jars for mdr"
	cd ${S}/mdr/external || die
	java-pkg_jar-from jmi-interface jmi.jar jmi.jar
	java-pkg_jar-from jmi-interface mof.jar mof.jar

	einfo "Symlinking jars for nbbuild"
	cd ${S}/nbbuild/external || die
	java-pkg_jar-from javahelp jhall.jar jhall-2.0_03.jar

	cd "${S}/serverplugins/external" || die
	# Builds just fine without this. Maybe lefover from times when NB could be
	# built with 1.4?
	rm -v jmxremote.jar || die

	einfo "Symlinking jars for tasklist"
	cd ${S}/tasklist/external || die
	java-pkg_jar-from --build-only ical4j
	java-pkg_jar-from --build-only jcalendar-1.2
	java-pkg_jar-from --build-only jtidy Tidy.jar Tidy-r7.jar

	einfo "Symlinking jars for web"
	cd ${S}/web/external || die
	java-pkg_jar-from --build-only commons-el
	java-pkg_jar-from jakarta-jstl jstl.jar jstl-1.1.2.jar
	java-pkg_jar-from --build-only servletapi-2.3 servlet.jar servlet-2.3.jar
	java-pkg_jar-from jakarta-jstl standard.jar standard-1.1.2.jar

	einfo "Symlinking jars for xml"
	cd ${S}/xml/external || die
	java-pkg_jar-from flute
	java-pkg_jar-from --build-only commons-jxpath commons-jxpath.jar jxpath1.1.jar
	java-pkg_jar-from --build-only prefuse-2006 prefuse.jar prefuse.jar
	java-pkg_jar-from sac
}

symlink_extjars() {
	einfo "Symlinking enterprise jars"

	cd ${1}/enterprise${ENTERPRISE}/modules/ext || die
	java-pkg_jar-from sun-j2ee-deployment-bin-1.1 sun-j2ee-deployment-bin.jar jsr88javax.jar
	java-pkg_jar-from jakarta-jstl jstl.jar
	java-pkg_jar-from jakarta-jstl standard.jar

	TARGET_DIR="enterprise${ENTERPRISE}/modules/ext/blueprints"
	cd ${1}/${TARGET_DIR} || die
	dosymjar ${TARGET_DIR} commons-fileupload commons-fileupload.jar commons-fileupload-1.1.1.jar
	dosymjar ${TARGET_DIR} commons-io-1 commons-io.jar commons-io-1.2.jar
	java-pkg_jar-from commons-logging commons-logging.jar commons-logging-1.1.jar

	TARGET_DIR="enterprise${ENTERPRISE}/modules/ext/jsf"
	cd ${1}/${TARGET_DIR} || die
	dosymjar ${TARGET_DIR} commons-beanutils-1.7 commons-beanutils.jar
	dosymjar ${TARGET_DIR} commons-collections commons-collections.jar
	dosymjar ${TARGET_DIR} commons-digester commons-digester.jar
	java-pkg_jar-from commons-logging commons-logging.jar

	TARGET_DIR="enterprise${ENTERPRISE}/modules/ext/struts"
	cd ${1}/${TARGET_DIR} || die
	dosymjar ${TARGET_DIR} antlr antlr.jar
	dosymjar ${TARGET_DIR} commons-beanutils-1.7 commons-beanutils.jar
	dosymjar ${TARGET_DIR} commons-digester commons-digester.jar
	dosymjar ${TARGET_DIR} commons-fileupload commons-fileupload.jar
	java-pkg_jar-from commons-logging commons-logging.jar
	dosymjar ${TARGET_DIR} commons-validator commons-validator.jar
	dosymjar ${TARGET_DIR} jakarta-oro-2.0 jakarta-oro.jar
	dosymjar ${TARGET_DIR} struts-1.2 struts.jar

	einfo "Symlinking harness jars"

	cd ${1}/harness || die
	java-pkg_jar-from javahelp jhall.jar jsearch-2.0_03.jar

	einfo "Symlinking ide jars"

	cd ${1}/ide${IDE_VERSION}/modules/ext || die
	java-pkg_jar-from commons-logging commons-logging.jar commons-logging-1.0.4.jar
	java-pkg_jar-from flute
	java-pkg_jar-from jgoodies-forms forms.jar forms-1.0.5.jar
	java-pkg_jar-from jmi-interface jmi.jar jmi.jar
	java-pkg_jar-from jsch jsch.jar jsch-0.1.24.jar
	java-pkg_jar-from junit junit.jar junit-3.8.1.jar
	java-pkg_jar-from jmi-interface mof.jar mof.jar
	java-pkg_jar-from sac
	java-pkg_jar-from servletapi-2.2 servlet.jar servlet-2.2.jar
	java-pkg_jar-from xerces-2 xercesImpl.jar xerces-2.8.0.jar
	java-pkg_jar-from xml-commons xml-apis.jar xml-commons-dom-ranges-1.0.b2.jar

	TARGET_DIR="ide${IDE_VERSION}/modules/ext/jaxrpc16"
	cd ${1}/${TARGET_DIR} || die
	dosymjar ${TARGET_DIR} sun-jaf activation.jar
	dosymjar ${TARGET_DIR} fastinfoset fastinfoset.jar FastInfoset.jar
	dosymjar ${TARGET_DIR} jaxp jaxp-ri.jar jaxp-api.jar
	dosymjar ${TARGET_DIR} jaxp jaxp-ri.jar jaxp-impl.jar
	dosymjar ${TARGET_DIR} jsr101 jaxrpc-api.jar
	dosymjar ${TARGET_DIR} jax-rpc jaxrpc-impl.jar
	dosymjar ${TARGET_DIR} jax-rpc jaxrpc-spi.jar
	dosymjar ${TARGET_DIR} jsr173 jsr173.jar jsr173_api.jar
	dosymjar ${TARGET_DIR} sun-javamail mail.jar
	dosymjar ${TARGET_DIR} relaxng-datatype relaxngDatatype.jar
	dosymjar ${TARGET_DIR} jsr67 jsr67.jar saaj-api.jar
	dosymjar ${TARGET_DIR} saaj saaj.jar saaj-impl.jar
	dosymjar ${TARGET_DIR} xsdlib xsdlib.jar

	TARGET_DIR="ide${IDE_VERSION}/modules/ext/jaxws21"
	cd ${1}/${TARGET_DIR} || die
	dosymjar ${TARGET_DIR} sun-jaf activation.jar
	dosymjar ${TARGET_DIR} fastinfoset fastinfoset.jar FastInfoset.jar
	dosymjar ${TARGET_DIR} sun-httpserver-bin-2 http.jar
	dosymjar ${TARGET_DIR} jaxb-2 jaxb-api.jar
	dosymjar ${TARGET_DIR} jaxb-2 jaxb-impl.jar
	dosymjar ${TARGET_DIR} jaxb-tools-2 jaxb-tools.jar jaxb-xjc.jar
	dosymjar ${TARGET_DIR} jax-ws-api-2 jax-ws-api.jar jaxws-api.jar
	dosymjar ${TARGET_DIR} jax-ws-2 jax-ws.jar jaxws-rt.jar
	dosymjar ${TARGET_DIR} jax-ws-2 jax-ws.jar jaxws-tools.jar
	dosymjar ${TARGET_DIR} jsr173 jsr173.jar jsr173_api.jar
	dosymjar ${TARGET_DIR} jsr181 jsr181.jar jsr181-api.jar
	dosymjar ${TARGET_DIR} jsr250 jsr250.jar jsr250-api.jar
	dosymjar ${TARGET_DIR} jsr67 jsr67.jar saaj-api.jar
	dosymjar ${TARGET_DIR} saaj saaj.jar saaj-impl.jar
	dosymjar ${TARGET_DIR} sjsxp sjsxp.jar

	einfo "Symlinking platform jars"
	cd ${1}/platform${PLATFORM}/modules/ext || die
	java-pkg_jar-from javahelp jh.jar jh-2.0_03.jar
	java-pkg_jar-from swing-layout-1 swing-layout.jar swing-layout-1.0.jar
}

dosymjar() {
	if [ -z "${4}" ]; then
		TARGET_FILE="${3}"
	else
		TARGET_FILE="${4}"
	fi
	dosym /usr/share/${2}/lib/${3} ${DESTINATION}/${1}/${TARGET_FILE}
}
