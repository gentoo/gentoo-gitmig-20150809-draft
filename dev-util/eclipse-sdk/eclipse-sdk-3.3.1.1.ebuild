# Copyright 2007-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/eclipse-sdk/eclipse-sdk-3.3.1.1.ebuild,v 1.2 2008/01/24 23:51:04 caster Exp $

# Notes: This is a preliminary ebuild of Eclipse-3.3
# It was based on the initial ebuild in the gcj-overlay, so much of the credit goes out to geki.

# Tomcat is almost no longer needed in 3.3 and removed in 3.4.
# See bug: https://bugs.eclipse.org/bugs/show_bug.cgi?id=173692
# Currently we remove the Tomcat stuff entirely - potentially this can still break things.
# We'll put it back if there is any bug report, which is unlikely.

# To unbundle a jar, do the following:
# 1) Rewrite the ebuild so it uses OSGi packaging
# 2) Add the dependency and add it to gentoo_jars/system_jars
# 3) Remove it from the build directory, and don't forget to modify the main Ant file
# so that it does *NOT* copy the file at the end
# 4) Install the symlink itself via java-pkg_jarfrom

# Jetty, Tomcat-jasper and Lucene analysis (1.9.1) jars have to stay bundled for now, until someone does some work on them.
# Hopefully, wltjr will soon package tomcat-jasper.

# Current patches are hard to maintain when revbumping.
# Two solutions:
# 1) Split patches so that there is one per file
# 2) Use sed, better solution I would say.

EAPI="1"
JAVA_PKG_IUSE="doc"
inherit java-pkg-2 java-ant-2 check-reqs

DMF="R-${PV}-200710231652"
MY_A="eclipse-sourceBuild-srcIncluded-${PV/.0}.zip"

DESCRIPTION="Eclipse Tools Platform"
HOMEPAGE="http://www.eclipse.org/"
SRC_URI="http://download.eclipse.org/eclipse/downloads/drops/${DMF}/${MY_A}"

SLOT="3.3"
LICENSE="EPL-1.0"
IUSE=""
KEYWORDS="~amd64 ~x86"

S=${WORKDIR}
PATCHDIR="${FILESDIR}/${SLOT}"
FEDORA="${PATCHDIR}/fedora"
ECLIPSE_DIR="/usr/lib/eclipse-${SLOT}"

CDEPEND=">=dev-java/ant-eclipse-ecj-3.3
	dev-java/ant-core
	dev-java/ant-nodeps
	=dev-java/junit-3*
	dev-java/junit:4
	>=dev-java/swt-${PV}
	>=dev-java/jsch-0.1.36-r1
	>=dev-java/icu4j-3.6.1
	>=dev-java/commons-el-1.0-r2
	>=dev-java/commons-logging-1.1-r4
	>=dev-java/tomcat-servlet-api-5.5.25-r1:2.4
	dev-java/lucene:1.9"

RDEPEND=">=virtual/jre-1.5
	${CDEPEND}"

DEPEND="=virtual/jdk-1.5*
	sys-apps/findutils
	dev-java/cldc-api:1.1
	app-arch/unzip
	app-arch/zip
	${CDEPEND}"

JAVA_PKG_BSFIX="off"

pkg_setup() {
	java-pkg-2_pkg_setup

	CHECKREQS_MEMORY="768"
	check_reqs

	eclipseArch=${ARCH}
	use amd64 && eclipseArch="x86_64"
}

src_unpack() {
	unpack "${A}"
	patch-apply
	remove-bundled-stuff

	# No warnings / Java 5 / all output should be directed to stdout
	find "${S}" -type f -name '*.xml' -exec \
		sed -r -e "s:(-encoding ISO-8859-1):\1 -nowarn:g" -e "s:(\"compilerArg\" value=\"):\1-nowarn :g" \
		-e "s:(<property name=\"javacSource\" value=)\".*\":\1\"1.5\":g" \
		-e "s:(<property name=\"javacTarget\" value=)\".*\":\1\"1.5\":g" -e "s:output=\".*(txt|log).*\"::g" -i {} \;

	# JDK home
	sed -r -e "s:^(JAVA_HOME =) .*:\1 $(java-config --jdk-home):" -e "s:gcc :gcc ${CFLAGS} :" \
		-i plugins/org.eclipse.core.filesystem/natives/unix/linux/Makefile || die "sed Makefile failed"

	while read line; do
		java-ant_rewrite-classpath "$line" > /dev/null
	done < <(find "${S}" -type f -name "build.xml" )
}

src_compile() {
	# Figure out correct boot classpath
	local bootClassPath=$(java-config --runtime)
	einfo "Using boot classpath ${bootClassPath}"

	java-pkg_force-compiler ecj-3.3

	# system_jars will be used when compiling (javac)
	# gentoo_jars will be used when building JSPs and other ant tasks (not javac)

	local systemJars="$(java-pkg_getjars swt-3,icu4j,ant-core,jsch,ant-nodeps,junit-4,tomcat-servlet-api-2.4,lucene-1.9):$(java-pkg_getjars --build-only cldc-api-1.1)"
	local gentooJars="$(java-pkg_getjars ant-core,icu4j,jsch,commons-logging,commons-el,tomcat-servlet-api-2.4)"
	local options="-q -Dnobootstrap=true -Dlibsconfig=true -Dbootclasspath=${bootClassPath} -DinstallOs=linux \
		-DinstallWs=gtk -DinstallArch=${eclipseArch} -Djava5.home=$(java-config --jdk-home)"

	use doc && options="${options} -Dgentoo.javadoc=true"

	ANT_OPTS=-Xmx1024M ANT_TASKS="ant-nodeps" eant ${options} -Dgentoo.classpath="${systemJars}" -Dgentoo.jars="${gentooJars//:/,}"
}

src_install() {
	dodir /usr/lib

	[[ -f result/linux-gtk-${eclipseArch}-sdk.tar.gz ]] || die "tar.gz bundle was not built properly!"
	tar zxf "result/linux-gtk-${eclipseArch}-sdk.tar.gz" -C "${D}/usr/lib" || die "Failed to extract the built package"

	mv "${D}/usr/lib/eclipse" "${D}/${ECLIPSE_DIR}"

	# Install startup script
	dobin "${FILESDIR}/${SLOT}/eclipse-${SLOT}"

	# Chmod the actual binary in the Eclipse dir
	chmod +x "${D}/${ECLIPSE_DIR}/eclipse"

	insinto "/etc" && doins "${FILESDIR}/${SLOT}/eclipserc"

	make_desktop_entry eclipse-${SLOT} "Eclipse ${PV}" "${ECLIPSE_DIR}/icon.xpm"

	cd "${D}/${ECLIPSE_DIR}"
	install-link-system-jars
}

pkg_postinst() {
	einfo
	einfo "Welcome to Eclipse-3.3 (Europa)!"
	einfo
	einfo "You can now install plugins via Update Manager without any"
	einfo "tweaking. This is the recommended way to install new features for Eclipse."
	einfo
	einfo "Please read http://gentoo-wiki.com/Eclipse"
	einfo "It contains a lot of useful information and help about Eclipse on Gentoo."
}

# -----------------------------------------------------------------------------
#  Helper functions
# -----------------------------------------------------------------------------

install-link-system-jars() {

	pushd plugins/ > /dev/null
	java-pkg_jarfrom swt-3

	mkdir "org.apache.ant"
	mkdir "org.apache.ant/META-INF/"
	mkdir "org.apache.ant/lib"
	cp "${FILESDIR}/${SLOT}/ant-osgi-manifest.mf" "org.apache.ant/META-INF/MANIFEST.MF"
	pushd org.apache.ant/lib > /dev/null
	java-pkg_jarfrom ant-core
	java-pkg_jarfrom ant-nodeps
	popd > /dev/null

	java-pkg_jarfrom icu4j
	java-pkg_jarfrom jsch
	java-pkg_jarfrom commons-el
	java-pkg_jarfrom commons-logging
	java-pkg_jarfrom lucene-1.9
	java-pkg_jarfrom tomcat-servlet-api-2.4

	popd > /dev/null

	pushd plugins/org.junit_*/ > /dev/null
	java-pkg_jarfrom junit
	popd > /dev/null

	pushd plugins/org.junit4*/ > /dev/null
	java-pkg_jarfrom junit-4
	popd > /dev/null
}

patch-apply() {
	# Patch launcher source
	mkdir launchertmp
	unzip -qq -d launchertmp plugins/org.eclipse.platform/launchersrc.zip > /dev/null || die "unzip failed"
	pushd launchertmp/ > /dev/null
	epatch "${PATCHDIR}/launcher_double-free.diff"
	sed -i "s/CFLAGS\ =\ -O\ -s\ -Wall/CFLAGS = ${CFLAGS}\ -Wall/" library/gtk/make_linux.mak \
		|| die "Failed to tweak make_linux.mak"
	zip -q -6 -r ../launchersrc.zip * >/dev/null || die "zip failed"
	popd > /dev/null
	mv launchersrc.zip plugins/org.eclipse.platform/launchersrc.zip
	rm -rf launchertmp

	# Disable SWT, JDT-Tool, JDK-6
	epatch "${PATCHDIR}/disable-swt.diff"
	epatch "${PATCHDIR}/disable-jdt-tool.diff"
	epatch "${PATCHDIR}/disable-jdk6.diff"
	epatch "${PATCHDIR}/set-java-home.diff" # this setups the java5 home variable

	# Following are patches from Fedora - I did not investigate this yet

	epatch "${FEDORA}/eclipse-libupdatebuild2.patch"

	# Fedora does not apply this anymore because they checkout
	# org.eclipse.equinox.initializer project from cvs. Untill a fix, we'll
	# keep the old patch
	pushd plugins/org.eclipse.core.runtime >/dev/null
	epatch "${FEDORA}/eclipse-fileinitializer.patch"
	popd >/dev/null

	# Generic releng plugins that can be used to build plugins
	# https://www.redhat.com/archives/fedora-devel-java-list/2006-April/msg00048.html
	pushd plugins/org.eclipse.pde.build > /dev/null
	# Patch 53
	epatch "${FEDORA}/eclipse-pde.build-add-package-build.patch"
	sed -e "s:@eclipse_base@:${ECLIPSE_DIR}:g" -i templates/package-build/build.properties
	popd > /dev/null

	# Gentoo patch to support jsch-0.1.36 - ali_bush
	# Already fixed in upstream svn.  Remove after next release?

	pushd "plugins/org.eclipse.jsch.ui" > /dev/null
	epatch "${PATCHDIR}/eclipse-jsch-api-update.patch"
	popd > /dev/null

	# Later we could produce a patch out of all these sed, but this is not the best solution
	# since this would make a lot of patches (x86, x86_64...) and would be hard to revbump

	# Following adds an additional classpath when building JSPs

	sed -i '/<path id="@dot\.classpath">/ a\
			<filelist dir="" files="${gentoo.jars}" />'  "plugins/org.eclipse.help.webapp/build.xml"

	# Following allows the doc USE flag to be honored

	sed -i -e '/<target name="generateJavadoc" depends="getJavadocPath"/ c\
		<target name="generateJavadoc" depends="getJavadocPath" if="gentoo.javadoc">' \
		-e '/<replace file="\${basedir}\/\${optionsFile}" token="@rt@" value="\${bootclasspath}/ c\
		<replace file="${basedir}/${optionsFile}" token="@rt@" value="${bootclasspath}:${gentoo.classpath}" />' \
		"plugins/org.eclipse.platform.doc.isv/buildDoc.xml"

	# Following disables Tomcat entirely

	sed -i '/plugins\/org\.eclipse\.tomcat"/{N;N;N;N;d;}' "features/org.eclipse.platform/build.xml"
	sed -i '/org\.eclipse\.tomcat/{N;N;N;d;}' "plugins/org.eclipse.platform.source/build.xml"
	sed -i '/<ant.*org\.eclipse\.tomcat/{N;N;d;}' "assemble.org.eclipse.sdk.linux.gtk.${eclipseArch}.xml"

	# This allows to compile osgi.util and osgi.service, and fixes IPluginDescriptor.class which is present compiled

	sed -i -e 's/<src path="\."/<src path="org"/' -e '/<include name="org\/"\/>/ d' \
	-e '/<subant antfile="\${customBuildCallbacks}" target="pre\.gather\.bin\.parts" failonerror="false" buildpath="\.">/ { n;n;n; a\
		<copy todir="${destination.temp.folder}/org.eclipse.osgi.services_3.1.200.v20070605" failonerror="true" overwrite="false"> \
			<fileset dir="${build.result.folder}/@dot"> \
				<include name="**"/> \
			</fileset> \
		</copy>
}' "plugins/org.eclipse.osgi.services/build.xml"

	sed -i -e 's/<src path="\."/<src path="org"/' -e '/<include name="org\/"\/>/ d' \
	-e '/<subant antfile="\${customBuildCallbacks}" target="pre\.gather\.bin\.parts" failonerror="false" buildpath="\.">/ { n;n;n; a\
		<copy todir="${destination.temp.folder}/org.eclipse.osgi.util_3.1.200.v20070605" failonerror="true" overwrite="false"> \
			<fileset dir="${build.result.folder}/@dot"> \
				<include name="**"/> \
			</fileset> \
		</copy>
}' 	"plugins/org.eclipse.osgi.util/build.xml"

	sed -i 	'/<mkdir dir="${temp\.folder}\/runtime_registry_compatibility\.jar\.bin"\/>/ a\
		<mkdir dir="classes"/> \
		<copy todir="classes" failonerror="true" overwrite="false"> \
			<fileset dir="${build.result.folder}/../org.eclipse.core.runtime/@dot/" includes="**/IPluginDescriptor.class" > \
			</fileset> \
		</copy>' "plugins/org.eclipse.core.runtime.compatibility.registry/build.xml"

	# This removes the copying operation for bundled jars

	sed -i -e "s/<copy.*com\.jcraft\.jsch.*\/>//" -e "s/<copy.*com\.ibm\.icu.*\/>//" -e "s/<copy.*org\.apache\.commons\.el_.*\/>//" \
		-e "s/<copy.*org\.apache\.commons\.logging_.*\/>//" -e "s/<copy.*javax\.servlet\.jsp_.*\/>//" -e "s/<copy.*javax\.servlet_.*\/>//" \
		-e "s/<copy.*org\.apache\.lucene_.*\/>//" "package.org.eclipse.sdk.linux.gtk.${eclipseArch}.xml"

	#  -e "s/<copy.*org\.apache\.lucene\.analysis_.*\/>//"
}

remove-bundled-stuff() {
	# Remove pre-built eclipse binaries
	find "${S}" -type f -name eclipse | xargs rm
	# ...  .so libraries
	find "${S}" -type f -name '*.so' | xargs rm
	# ... .jar files
	rm plugins/org.eclipse.swt/extra_jars/exceptions.jar plugins/org.eclipse.osgi/osgi/osgi*.jar \
		plugins/org.eclipse.osgi/supplement/osgi/osgi.jar

	rm -rf plugins/org.eclipse.swt.*
	rm -rf plugins/org.apache.ant_*
	rm plugins/org.apache.commons.*.jar
	rm plugins/com.jcraft.jsch*
	rm plugins/com.ibm.icu*
	rm plugins/org.junit_*/*.jar
	rm plugins/org.junit4*/*.jar
	rm plugins/javax.*.jar
	rm plugins/org.apache.lucene_*.jar

	# Removing Tomcat stuff

	rm -rf "plugins/org.eclipse.tomcat/"

	# Remove bundled classes

	rm -rf "plugins/org.eclipse.osgi.services/org"
	unzip -q "plugins/org.eclipse.osgi.services/src.zip" -d "plugins/org.eclipse.osgi.services/"
	rm -rf "plugins/org.eclipse.osgi.util/org"
	unzip -q "plugins/org.eclipse.osgi.util/src.zip" -d "plugins/org.eclipse.osgi.util/"

	rm -rf plugins/org.eclipse.jdt.core/scripts/*.class
	rm -rf plugins/org.eclipse.core.runtime.compatibility.registry/classes
}
