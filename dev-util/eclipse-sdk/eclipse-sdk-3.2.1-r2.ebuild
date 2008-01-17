# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/eclipse-sdk/eclipse-sdk-3.2.1-r2.ebuild,v 1.7 2008/01/17 21:29:34 betelgeuse Exp $

EAPI=1

inherit eutils java-pkg-2 flag-o-matic check-reqs multilib

DATESTAMP="200609210945"
MY_A="eclipse-sourceBuild-srcIncluded-${PV}.zip"
DESCRIPTION="Eclipse Tools Platform"
HOMEPAGE="http://www.eclipse.org/"
SRC_URI="http://download.eclipse.org/eclipse/downloads/drops/R-${PV}-${DATESTAMP}/${MY_A}
mirror://gentoo/${P}-r1-patches.tar.bz2"
IUSE="branding cairo gnome opengl seamonkey "
SLOT="3.2"
LICENSE="EPL-1.0"
# TODO might be able to have ia64 and ppc64 support
KEYWORDS="amd64 ppc x86"
S="${WORKDIR}"

COMMON_DEP="
	>=x11-libs/gtk+-2.2.4
	seamonkey? ( www-client/seamonkey )
	gnome? ( =gnome-base/gnome-vfs-2* =gnome-base/libgnomeui-2* )
	opengl? ( virtual/opengl )
	>=dev-java/ant-1.7.0
	=dev-java/junit-3*
	dev-java/lucene:1"

RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"
DEPEND="
	${COMMON_DEP}
	=virtual/jdk-1.4*
	>=virtual/jdk-1.5
	>=sys-apps/findutils-4.1.7
	app-arch/unzip
	app-arch/zip"

# Force 1.4 to be used for building
JAVA_PKG_NV_DEPEND="=virtual/jdk-1.4*"

ECLIPSE_DIR="/usr/lib/eclipse-${SLOT}"
ECLIPSE_LINKS_DIR="${ECLIPSE_DIR}/links"

# TODO:
# - use CFLAGS from make.conf when building native libraries
#   - must patch eclipse build files
#   - also submit patch to bugs.eclipse.org
# - ppc support not tested, but not explicitly broken either
# - make a extension location in /var/lib that's writable by 'eclipse' group
# - update man page

pkg_setup() {
	java-pkg-2_pkg_setup

	debug-print "Checking for sufficient physical RAM"
	CHECKREQS_MEMORY="768"
	check_reqs

	# All other gentoo archs match in eclipse build system except amd64
	if use amd64 ; then
		eclipsearch=x86_64
	else
		eclipsearch=${ARCH}
	fi

	if use x86 ; then
		jvmarch=i386
	else
		jvmarch=${ARCH}
	fi

	# Add the eclipse group, for our plugins/features directories
	enewgroup eclipse
}

src_unpack() {
	unpack ${A}

	fix-swt-targets

	pushd plugins/org.apache.ant >/dev/null || die "pushd failed"
	rm -rf lib
	ln -s /usr/share/ant/lib lib
	popd >/dev/null

	pushd plugins/org.junit >/dev/null
	rm *.jar
	java-pkg_jar-from junit
	popd >/dev/null

	pushd plugins/org.apache.lucene >/dev/null
	rm *.jar
	java-pkg_jar-from lucene-1 lucene.jar lucene-1.4.3.jar
	popd >/dev/null
	# For some reason popd above fails to go back to workdir.
	# ^Was caused by the three argument form of java-pkg_jar-from
	# that Caster recently broke in the eclass. The cd here does not
	# hurt and I like these comments.
	# https://bugs.gentoo.org/show_bug.cgi?id=163969
	cd "${WORKDIR}"
	apply-patchset
}

src_compile() {
	# Figure out VM, set up ant classpath and native library paths
	setup-jvm-opts

	if use seamonkey ; then
		einfo "Will compile embedded seamonkey support against www-client/seamonkey"
		setup-mozilla-opts
	else
		einfo "Not building embedded seamonkey support"
	fi

	local java5vm=$(depend-java-query --get-vm ">=virtual/jdk-1.5")
	local java5home=$(GENTOO_VM=${java5vm} java-config --jdk-home)
	einfo "Using ${java5home} for java5home"
	# TODO patch build to take buildId
	./build -os linux \
		-arch ${eclipsearch} \
		-ws gtk \
		-java5home ${java5home} || die "build failed"
}

src_install() {
	dodir /usr/lib

	# TODO maybe there's a better way of installing than extracting the tar?
	[[ -f result/linux-gtk-${eclipsearch}-sdk.tar.gz ]] || die "tar.gz bundle was not built properly!"
	tar zxf result/linux-gtk-${eclipsearch}-sdk.tar.gz -C ${D}/usr/lib \
		|| die "Failed to extract the built package"

	mv ${D}/usr/lib/eclipse ${D}/${ECLIPSE_DIR}
	#insinto ${ECLIPSE_DIR}
	echo "-Djava.library.path=/usr/lib" >> ${D}/${ECLIPSE_DIR}/eclipse.ini

	debug-print "Installing eclipse-gtk binary"
	exeinto ${ECLIPSE_DIR}
	doexe eclipse || die "Failed to install eclipse binary"

	# Install startup script
	exeinto /usr/bin
	doexe ${FILESDIR}/eclipse-${SLOT}

	make_desktop_entry eclipse-${SLOT} "Eclipse ${PV}" "${ECLIPSE_DIR}/icon.xpm"
}

# -----------------------------------------------------------------------------
#  Helper functions
# -----------------------------------------------------------------------------

apply-patchset() {
	# begin: patches/comments from fedora

	# Build JNI libs
	# FIXME:  these should be built by upstream build method
	# http://www.bagu.org/eclipse/plugin-source-drops.html
	# https://bugs.eclipse.org/bugs/show_bug.cgi?id=71637
	# https://bugs.eclipse.org/bugs/show_bug.cgi?id=86848
	# GNU XML issue identified by Michael Koch
	# %patch2 -p0
	epatch ${WORKDIR}/${P}-build.patch
	# %patch4 -p0
	epatch ${WORKDIR}/${P}-libupdatebuild.patch
	# %patch5 -p0
	epatch ${WORKDIR}/${P}-libupdatebuild2.patch
	# Build swttools.jar
	# https://bugs.eclipse.org/bugs/show_bug.cgi?id=90364
	pushd plugins/org.eclipse.swt.gtk.linux.x86_64 >/dev/null
	# %patch18 -p0
	epatch ${WORKDIR}/${P}-swttools.patch
	popd >/dev/null
	# https://bugs.eclipse.org/bugs/show_bug.cgi?id=90630
	# %patch22 -p0
	epatch ${WORKDIR}/${P}-updatehomedir.patch
	# https://bugs.eclipse.org/bugs/show_bug.cgi?id=90535
	pushd plugins/org.eclipse.core.runtime >/dev/null
	# %patch24 -p0
	epatch ${WORKDIR}/${P}-fileinitializer.patch
	popd >/dev/null

	##
	## FIXME: breaks!!
	##
	## tomcat patches
	## These patches need to go upstream
	## https://bugs.eclipse.org/bugs/show_bug.cgi?id=98371
	#pushd plugins/org.eclipse.tomcat >/dev/null
	## %patch28 -p0
	#epatch ${WORKDIR}/${P}-tomcat55.patch
	## %patch29 -p0
	#epatch ${WORKDIR}/${P}-tomcat55-build.patch
	#popd >/dev/null
	#sed --in-place "s/4.1.130/5.5.17/"                      \
	#		features/org.eclipse.platform/build.xml \
	#		plugins/org.eclipse.tomcat/build.xml    \
	#		assemble.*.xml
	#pushd plugins/org.eclipse.help.webapp >/dev/null
	## %patch31 -p0
	#epatch ${WORKDIR}/${P}-webapp-tomcat55.patch
	#popd >/dev/null

	# pushd plugins/org.eclipse.compare
	# COMMENTED BY FEDORA %patch33 -p0
	# popd

	# JPackage []s in names of symlinks ...
	# https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=162177
	pushd plugins/org.eclipse.jdt.core >/dev/null
	# %patch34 -p0
	epatch ${WORKDIR}/${P}-bz162177.patch
	# Use ecj for gcj
	# %patch57 -p0
	epatch ${WORKDIR}/${P}-ecj-gcj.patch
	popd >/dev/null
	# https://bugs.eclipse.org/bugs/show_bug.cgi?id=114001
	# %patch38 -p0
	epatch ${WORKDIR}/${P}-helpindexbuilder.patch
	# %patch40 -p0
	epatch ${WORKDIR}/${P}-usebuiltlauncher.patch
	# DO NOT APPLY %patch43
	pushd plugins/org.eclipse.swt/Eclipse\ SWT\ Mozilla/common/library >/dev/null
	# Build cairo native libs
	# %patch46
	# epatch ${WORKDIR}/${P}-libswt-xpcomgcc4.patch
	popd >/dev/null

	# Because the launcher source is zipped up, we need to unzip, patch, and re-pack
	mkdir launchertmp
	unzip -qq -d launchertmp plugins/org.eclipse.platform/launchersrc.zip >/dev/null || die "unzip failed"
	# https://bugs.eclipse.org/bugs/show_bug.cgi?id=79592
	# https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=168726
	pushd launchertmp >/dev/null
	# %patch47 -p1
	epatch ${WORKDIR}/${P}-launcher-link.patch
	zip -q -9 -r ../launchersrc.zip * >/dev/null || die "zip failed"
	popd >/dev/null
	mv launchersrc.zip plugins/org.eclipse.platform
	rm -rf launchertmp

	pushd features/org.eclipse.platform.launchers >/dev/null
	# %patch47 -p1
	epatch ${WORKDIR}/${P}-launcher-link.patch
	popd >/dev/null
	# Link against our system-installed javadocs
	# Don't attempt to link to Sun's javadocs
	# %patch48 -p0
	epatch ${WORKDIR}/${P}-javadoclinks.patch
	sed --in-place "s:/usr/share/:%{_datadir}/:g"           \
		plugins/org.eclipse.jdt.doc.isv/jdtOptions.txt  \
		plugins/org.eclipse.pde.doc.user/pdeOptions.txt \
		plugins/org.eclipse.pde.doc.user/pdeOptions     \
		plugins/org.eclipse.platform.doc.isv/platformOptions.txt
	# Always generate debug info when building RPMs (Andrew Haley)
	# %patch49 -p0
	epatch ${WORKDIR}/${P}-ecj-rpmdebuginfo.patch

	# generic releng plugins that can be used to build plugins
	# see this thread for deails:
	# https://www.redhat.com/archives/fedora-devel-java-list/2006-April/msg00048.html
	pushd plugins/org.eclipse.pde.build >/dev/null
	# %patch53
	epatch ${WORKDIR}/${P}-pde.build-add-package-build.patch
	sed --in-place "s:@eclipse_base@:%{_datadir}/%{name}:" templates/package-build/build.properties
	popd >/dev/null

	# https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=191536
	# https://bugs.eclipse.org/bugs/show_bug.cgi?id=142861
	pushd plugins/org.eclipse.swt/Eclipse\ SWT >/dev/null
	# %patch54
	epatch ${WORKDIR}/${P}-swt-rm-ON_TOP.patch
	popd >/dev/null

	# We need to disable junit4 and apt until GCJ can handle Java5 code
	# %patch55 -p0
	epatch ${WORKDIR}/${P}-disable-junit4-apt.patch
	rm plugins/org.junit4/junit-4.1.jar

	##
	## FIXME: breaks!!
	##
	## I love directories with spaces in their names
	#pushd plugins/org.eclipse.swt >/dev/null
	#mv "Eclipse SWT Mozilla" Eclipse_SWT_Mozilla
	#mv "Eclipse SWT PI" Eclipse_SWT_PI
	## Build against firefox:
	##  - fix swt profile include path
	##  - don't compile the mozilla 1.7 / firefox profile library -- build it inline
	##  - don't use symbols not in our firefox builds
	## FIXME:  add reference(s) to discussion(s) and bug(s)
	## Note:  I made this patch from within Eclipse and then did the following to
	##        it due to spaces in the paths:
	##  sed --in-place "s/Eclipse\ SWT\ Mozilla/Eclipse_SWT_Mozilla/g" eclipse-swt-firefox.patch
	##  sed --in-place "s/Eclipse\ SWT\ PI/Eclipse_SWT_PI/g" eclipse-swt-firefox.patch
	## %patch59
	#epatch ${WORKDIR}/${P}-swt-firefox.patch
	#mv Eclipse_SWT_Mozilla "Eclipse SWT Mozilla"
	#mv Eclipse_SWT_PI "Eclipse SWT PI"
	#popd >/dev/null
	#pushd plugins/org.eclipse.swt.tools >/dev/null
	#mv "JNI Generation" JNI_Generation
	## %patch60
	#epatch ${WORKDIR}/${P}-swt-firefox.2.patch
	#mv JNI_Generation "JNI Generation"
	#popd >/dev/null

	# FIXME check if this has been applied upstream
	pushd plugins/org.eclipse.platform.doc.isv >/dev/null
	# %patch100 -p0
	epatch ${WORKDIR}/customBuildCallbacks.xml-add-pre.gather.bin.parts.patch
	popd >/dev/null
	pushd plugins/org.eclipse.platform.doc.user >/dev/null
	# %patch100 -p0
	epatch ${WORKDIR}/customBuildCallbacks.xml-add-pre.gather.bin.parts.patch
	popd >/dev/null

	if use branding; then
		pushd plugins/org.eclipse.platform >/dev/null
		cp ${WORKDIR}/splash.bmp .
		popd >/dev/null
	fi

	# FIXME this should be patched upstream with a flag to turn on and off
	# all output should be directed to stdout
	find -type f -name \*.xml -exec sed --in-place -r "s/output=\".*(txt|log).*\"//g" "{}" \;
}

fix-swt-targets() {
	# Build using O2
	# https://bugs.eclipse.org/bugs/show_bug.cgi?id=71637
	pushd plugins/org.eclipse.swt/Eclipse\ SWT\ PI/gtk/library >/dev/null
	# %patch0 -p0
	epatch ${WORKDIR}/${P}-gentoo-libswt-enableallandO2.patch
	popd >/dev/null

	# Select the set of native libraries to compile
	local targets="make_swt make_awt make_atk"

	if use gnome ; then
		einfo "Enabling GNOME VFS support"
		targets="${targets} make_gnome"
	fi

	if use seamonkey ; then
		einfo "Enabling embedded Mozilla support"
		targets="${targets} make_mozilla"
	fi

	if use cairo ; then
		einfo "Enabling CAIRO support"
		targets="${targets} make_cairo"
	fi

	if use opengl ; then
		einfo "Enabling OpenGL support"
		targets="${targets} make_glx"
	fi

	sed -i "s/^all:.*/all: ${targets}/" \
		"plugins/org.eclipse.swt/Eclipse SWT PI/gtk/library/make_linux.mak" \
		|| die "Failed to tweak make_linux.mak"
}

setup-jvm-opts() {
	# Figure out correct boot classpath
	# karltk: this should be handled by the java-pkg eclass in setup-vm
	local bp="$(java-config --jdk-home)/jre/lib"
	local bootclasspath=$(java-config --runtime)
	if [[ ! -z "`java-config --java-version | grep IBM`" ]] ; then
		# IBM JDK
		JAVA_LIB_DIR="$(java-config --jdk-home)/jre/bin"
	else
		# Sun derived JDKs (Blackdown, Sun)
		JAVA_LIB_DIR="$(java-config --jdk-home)/jre/lib/${jvmarch}"
	fi

	einfo "Using bootclasspath ${bootclasspath}"
	einfo "Using JVM library path ${JAVA_LIB_DIR}"

	if [[ ! -f ${JAVA_LIB_DIR}/libawt.so ]] ; then
		die "Could not find libawt.so native library"
	fi

	export AWT_LIB_PATH=${JAVA_LIB_DIR}
}

setup-mozilla-opts() {
	export GECKO_SDK="/usr/$(get_libdir)/seamonkey"
	# TODO should this be using pkg-config?
	export GECKO_INCLUDES=$(pkg-config seamonkey-gtkmozembed --cflags)
	export GECKO_LIBS=$(pkg-config seamonkey-gtkmozembed --libs)
}

pkg_postinst() {
	einfo "Users can now install plugins via Update Manager without any"
	einfo "tweaking."
	echo
	einfo "Eclipse plugin packages (ie eclipse-cdt) will likely go away in"
	einfo "the near future until they can be properly packaged. Update Manager"
	einfo "is prefered in the meantime."
}
