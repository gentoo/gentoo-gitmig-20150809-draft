# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/eclipse-sdk/eclipse-sdk-3.1_pre6.ebuild,v 1.1 2005/04/06 19:38:00 karltk Exp $

inherit eutils java-utils

# karltk: Portage 2.0.51_pre13 needs this
MY_A="eclipse-sourceBuild-srcIncluded-3.1M6.zip"
DESCRIPTION="Eclipse Tools Platform"
HOMEPAGE="http://www.eclipse.org/"
SRC_URI="http://download.eclipse.org/downloads/drops/S-3.1M6-200504011645/${MY_A}"
IUSE="gnome mozilla jikes nosrc nodoc"
SLOT="3.1"
LICENSE="CPL-1.0"
KEYWORDS="~x86 ~ppc"

RDEPEND="
	|| ( >=virtual/jre-1.4.2 =dev-java/blackdown-jdk-1.4.2* )
	>=x11-libs/gtk+-2.2.4
	mozilla? ( >=www-client/mozilla-1.4* )
	jikes? ( >=dev-java/jikes-1.21 )
	gnome? ( =gnome-base/gnome-vfs-2* =gnome-base/libgnomeui-2* )"

DEPEND="${RDEPEND}
	>=dev-java/ant-1.5.3
	>=sys-apps/findutils-4.1.7
	>=app-shells/tcsh-6.11
	app-arch/unzip
	app-arch/zip"

pkg_setup() {

	check-ram
	check-cflags

	java-utils_setup-vm

	java-utils_ensure-vm-version-ge 1 4 2

	if (java-utils_is-vm-version-ge 1 5 0) ; then
		die "${P} cannot be compiled with a 1.5.x VM, set your system VM to a 1.4.x VM."
	fi

}

src_unpack() {

	setup-dir-vars

	mkdir ${S}
	cd ${S}
	unpack ${MY_A} || die "Could not unpack ${MY_A}"

	einfo "Setting up virtual machine"
	java-utils_setup-vm

	einfo "Patching build.xmls"
	process-build-xmls

	einfo "Cleaning out prebuilt code"
	clean-prebuilt-code

	einfo "Patching frontend"
	patch-frontend

	einfo "Set build version in Help->About"
	patch-about
}

src_compile() {

	${use_gtk} && use mozilla && detect-mozilla
	setup-dir-vars

	# karltk: this should be handled by the java-pkg eclass in setup-vm 
	addwrite "/proc/self/maps"
	addwrite "/proc/cpuinfo"
	addwrite "/dev/random"

	# Figure out VM, set up classpath and other Ant options
	setup-ant-opts

	einfo "Building native front end code"
	build-native

	einfo "Building core resources"
	build-core-resources

	einfo "Bootstrapping ecj compiler"
	build-compiler

	einfo "Compiling all Java code"
	build-java compile

	einfo "Installing all code"
	build-java install

	einfo "Creating .desktop entry"
	create-desktop-entry
}

src_install() {

	setup-dir-vars

	eclipse_dir="/usr/lib/eclipse-${SLOT}"

	dodir /usr/lib

	einfo "Installing features and plugins"

	[ -f result/org.eclipse.sdk-I*-linux.gtk.${ARCH}.tar.gz ] || die "gtk zip bundle was not build properly!"
	tar zxf result/org.eclipse.sdk-I*-linux.gtk.${ARCH}.tar.gz -C ${D}/usr/lib

	mv ${D}/usr/lib/eclipse ${D}/${eclipse_dir}

	insinto ${eclipse_dir}

	# Install launchers and native code
	exeinto ${eclipse_dir}

	einfo "Installing eclipse-gtk binary"
	doexe ${launcher_src_dir}/eclipse-gtk || die "Failed to install eclipse-gtk"

	doins plugins/org.eclipse.platform/{startup.jar,splash.bmp}

	if use nosrc ; then
		einfo "Stripping away source code"
		strip-src
	fi

	if use nodoc ; then
		einfo "Stripping away documentation"
		strip-docs
	fi

	# Install startup script
	exeinto /usr/bin
	doexe ${FILESDIR}/eclipse-${SLOT}

	install-desktop-entry

	doman ${FILESDIR}/eclipse.1

	install-link-files
}

pkg_postinst()
{
	check-cflags
}

# -----------------------------------------------------------------------------
#  Helper functions
# -----------------------------------------------------------------------------

function detect-mozilla()
{
	mozilla_dir="--mozdir-unset---"

	if [ -f ${ROOT}/usr/lib/mozilla/libgtkembedmoz.so ] ; then
		einfo "Compiling against www-client/mozilla"
		mozilla_dir=/usr/lib/mozilla
	elif [ -f ${ROOT}/usr/lib/MozillaFirefox/libgtkembedmoz.so ] ; then
		einfo "Compiling against www-client/mozilla-firefox"
		mozilla_dir=/usr/lib/MozillaFirefox
	else
		eerror "You have enabled the embedded mozilla component, but no suitable"
		eerror "provider was found. You need Mozilla or Firefox compiled against"
		eerror "gtk+ v2.0 or newer."
		eerror "To merge it, execute 'USE=\"gtk2\" emerge mozilla' as root."
		eerror "To disable embedded mozilla, remove \"mozilla\" from your USE flags."
		die "Need Mozilla compiled with gtk+-2.x support"
	fi
}

function setup-dir-vars() {
	launcher_src_dir="features/org.eclipse.launchers/library/gtk"
	swt_src_dir="plugins/org.eclipse.swt/Eclipse SWT PI/gtk/library"

	core_src_dir="plugins/org.eclipse.core.resources.linux/src"

	case ${ARCH} in
		x86)
			swt_dest_dir="plugins/org.eclipse.swt.gtk/os/linux/x86"
			core_dest_dir="plugins/org.eclipse.core.resources.linux/os/linux/x86"
			;;
		ppc)
			swt_dest_dir="plugins/org.eclipse.swt.gtk/os/linux/ppc"
			core_dest_dir="plugins/org.eclipse.core.resources.linux/os/linux/ppc/"
			;;
	esac
}

function process-build-xmls() {

	# Turn off verbose mode and on errors in all build.xml files
	find . -type f -name "build.xml" | while read x ; do
		sed -i -r \
			-e 's/failonerror="[^"]+"/failonerror="true"/' \
			-e 's/verbose="[^"]+"/verbose="false"/' "$x"
	done
}

function patch-frontend() {

	# Move around some source code that should have been handled by the build system
	# Some files are arbitrarily duplicated (make_common.mak), but others are not.
	# I'm feeling inclined to start using the term "eclipse logic" to refer to build
	# system strangeness, because this build system has heaploads and heaploads of
	# weird idiosyncracies, and they keep changing between minor versions. Hurrah. -- karltk

	local m="Failed to move native files for SWT gtk+"
	cp ${S}/plugins/org.eclipse.swt/Eclipse\ SWT/common/library/* ${S}/"${swt_src_dir}" || die ${m}
	cp ${S}/plugins/org.eclipse.swt/Eclipse\ SWT\ Mozilla/common/library/* ${S}/"${swt_src_dir}" || die ${m}
	cp ${S}/plugins/org.eclipse.swt/Eclipse\ SWT\ Program/gnome/library/* ${S}/"${swt_src_dir}" || die ${m}
	cp ${S}/plugins/org.eclipse.swt/Eclipse\ SWT\ AWT/gtk/library/* ${S}/"${swt_src_dir}" || die ${m}
}

function create-desktop-entry() {

	cat ${FILESDIR}/eclipse-${SLOT}.desktop | \
		sed -e "s/@PV@/${PV}/" \
		> eclipse-${SLOT}.desktop || die "Failed to create desktop entry"
}

function build-java() {
	local target=${1}

	einfo "Building GTK+ frontend (${target}) -- see compilelog.txt for details"
	LOCALCLASSPATH=jdtcore.jar ant -q -q  \
		-buildfile build.xml \
		-DcollPlace="eclipse-${SLOT}" \
		-DinstallOs=linux \
		-DinstallWs=gtk \
		-DinstallArch=$ARCH \
		${ant_extra_opts} ${target} \
		|| die "Failed to ${target} Java code (gtk+)"
}

function install-desktop-entry() {

	dodir /usr/share/applnk/Development
	insinto /usr/share/applnk/Development
	doins eclipse-${SLOT}.desktop
}

function build-native() {

	einfo "Building SWT"

	# Perpare destination directory
	mkdir -p ${S}/"${swt_dest_dir}"


	einfo "Building the eclipse-gtk binary"

	cd ${S}/${launcher_src_dir}
	PROGRAM_OUTPUT=eclipse-gtk \
		DEFAULT_OS=linux \
		DEFAULT_OS_ARCH=${ARCH} \
		DEFAULT_WS=gtk \
		make -f make_linux.mak || die "Failed to build eclipse-gtk"

	cd ${S}/"${swt_src_dir}"

	einfo "Building the SWT bindings"

	# Disabled for 3.1 series
	#	KDE_LIB_PATH=$(kde-config --prefix)/lib
	#	KDE_INCLUDE_PATH=$(kde-config --prefix)/include

	local awt_lib_path

	[ ${ARCH} == 'x86' ] && awt_lib_path=${JAVA_HOME}/jre/lib/i386
	[ ${ARCH} == 'amd64' ] && awt_lib_path=${JAVA_HOME}/jre/lib/amd64

	[ ${ARCH} == 'amd64' ] && swt_ptr_cflags=-DSWT_PTR_SIZE_64

	[ ${ARCH} == 'x86' ] && output_dir="../../../org.eclipse.swt.gtk/os/linux/x86"
	[ ${ARCH} == 'ppc' ] && output_dir="../../../org.eclipse.swt.gtk64/os/linux/ppc"
	[ ${ARCH} == 'amd64' ] && output_dir="../../../org.eclipse.swt.gtk64/os/linux/x86_64"

	export AWT_LIB_PATH=${awt_lib_path}
	export XTEST_LIB_PATH=/usr/X11R6/lib
	export GECKO_SDK=/usr/lib/mozilla
	export GECKO_INCLUDES="-include ${GECKO_SDK}/include/mozilla-config.h \
			-I${GECKO_SDK}/include/nspr \
			-I${GECKO_SDK}/include/nspr \
			-I${GECKO_SDK}/include/xpcom \
			-I${GECKO_SDK}/include/string \
			-I${GECKO_SDK}/include/embed_base"
	export GECKO_LIBS="-L${GECKO_SDK} -lgtkembedmoz"
	export SWT_PTR_CFLAGS="${swt_ptr_cflags} -I${JAVA_HOME}/include/linux"
	export OUTPUT_DIR=${output_dir}


	einfo "Building SWT support"
	make -f make_linux.mak make_swt || "Failed to build SWT support"
	cp libswt-gtk-*.so libswt-pi-gtk-*.so ${S}/"${swt_dest_dir}" || die "Failed to copy SWT .so files"

	einfo "Building AWT support"
	make -f make_linux.mak make_awt || "Failed to build AWT support"
	cp libswt-awt-gtk-*.so ${S}/"${swt_dest_dir}" || die "Failed to copy AWT .so"

	if use gnome ; then
		einfo "Building GNOME VFS support"
		make -f make_linux.mak make_gnome || die "Failed to build GNOME VFS support"
		cp libswt-gnome-gtk-*.so ${S}/"${swt_dest_dir}" || die "Failed to copy GNOME VFS .so files"
	fi

	if use mozilla ; then
		einfo "Building Mozilla component"
		make -f make_linux.mak make_mozilla || die "Failed to build Mozilla support"
		cp libswt-mozilla-gtk-*.so ${S}/"${swt_dest_dir}" || die "Failed to copy GNOME VFS .so files"
	fi

	cd ${S}

	einfo "Native gtk+ bindings built"
}

function clean-prebuilt-code() {

	einfo "Cleaning all pre-built code"

	ant -q -DinstallWs=gtk -DinstallOs=linux clean
	ant -q -DinstallWs=motif -DinstallOs=linux clean
	find ${S} -name '*.so' -exec rm -f {} \;
	find ${S} -name '*.so.*' -exec rm -f {} \;
	find ${S} -type f -name 'eclipse' -exec rm {} \;
	rm -f eclipse

}

function get-memory-total() {
	cat /proc/meminfo | grep MemTotal | sed -r "s/[^0-9]*([0-9]+).*/\1/"
}

function check-ram() {

	einfo "Checking for sufficient physical RAM"

	local mem=$(get-memory-total)
	[ $(get-memory-total) -lt 775000 ] &&
		(
		echo
		ewarn "To build Eclipse, at least 768MB of RAM is recommended."
		ewarn "Your machine has less RAM. Continuing anyway."
		echo
		)
}

function install-link-files() {

	einfo "Installing link files"

	dodir /usr/lib/eclipse-${SLOT}/links

	echo "path=/opt/eclipse-extensions-3" > ${D}/${eclipse_dir}/links/eclipse-binary-extensions-3.link
	echo "path=/opt/eclipse-extensions-3.1" > ${D}/${eclipse_dir}/links/eclipse-binary-extensions-3.1.link

	echo "path=/usr/lib/eclipse-extensions-3" > ${D}/${eclipse_dir}/links/eclipse-extensions-3.link
	echo "path=/usr/lib/eclipse-extensions-3.1" > ${D}/${eclipse_dir}/links/eclipse-extensions-3.1.link
}

function check-cflags() {

	einfo "Checking for bad CFLAGS"

	local badflags="-fomit-frame-pointer -msse2"
	local error=false

	for x in ${badflags} ; do
		if [ ! -z "$(echo ${CFLAGS} | grep -- $x)" ] ; then
			ewarn "Found offending option $x in your CFLAGS"
			error=true
		fi
	done
	if [ ${error} == "true" ]; then
		echo
		ewarn "One or more potentially gruesome CFLAGS detected. When you run into trouble,"
		ewarn "please edit /etc/make.conf and remove all offending flags, then recompile"
		ewarn "Eclipse and all its dependencies before submitting a bug report."
		echo
		einfo "Tip: use equery depgraph \"=${PF}\" to list all dependencies"
		echo
		ebeep
	fi
}

function patch-about() {

	find -type f -name about.mappings -exec sed -e "s/@build@/Gentoo Linux ${PF}/" -i \{\} \; \
		|| die "Failed to patch about.mappings"

	sed -e "s/@build@/Gentoo Linux ${PF}/" \
		-i features/org.eclipse.platform/gtk/configuration/config.ini \
		-i features/org.eclipse.platform/motif/configuration/config.ini \
		-i build.xml || die "Failed to set build version"
}

function build-compiler() {

	pushd .
	cd jdtcoresrc

	# WTF? Why does compilejdtcorewithjavac.xml delete its own source code?
	# See their #90319.
	[ -f src/jdtcore.zip ] && cp src/jdtcore.zip jdtcore.zip-backup
	[ -f jdtcore.zip-backup ] && cp jdtcore.zip-backup src/jdtcore.zip

	use jikes && antopts="-Dbuild.compiler=jikes"

	ant ${antopts} -q -f compilejdtcorewithjavac.xml || die "Failed to bootstrap jdtcore compiler"
	LOCALCLASSPATH=jdtcore.jar ant -q -f compilejdtcore.xml || die "Failed to compile jdtcore"

	# WTF? Just to make things interesting, compilejdtcore.xml suddenly moves jdtcore.jar to ../

	popd
}

function setup-ant-opts() {

	# Figure out correct boot classpath
	# karltk: this should be handled by the java-pkg eclass in setup-vm
	if [ ! -z "`java-config --java-version | grep IBM`" ] ; then
		# IBM JRE
		local bp="$(java-config --jdk-home)/jre/lib"
		ant_extra_opts="-Dbootclasspath=${bp}/core.jar:${bp}/xml.jar:${bp}/graphics.jar:${bp}/security.jar"
	else
		# Sun derived JREs (Blackdown, Sun)
		local bp="$(java-config --jdk-home)/jre/lib"
		ant_extra_opts="-Dbootclasspath=${bp}/rt.jar:${bp}/jsse.jar"
	fi

	einfo "Using ant_extra_opts=${ant_extra_opts}"
	export ANT_OPTS=-Xmx768m
}

function build-core-resources() {

	cd ${S}/${core_src_dir}
	make \
		JDK_INCLUDE="-I`java-config -O`/include -I`java-config -O`/include/linux" || die "Failed to build core resources"

	mkdir -p ${S}/"${core_dest_dir}"
	mv libcore*.so ${S}/"${core_dest_dir}"
	cd ${S}
}

function strip-src() {

	local bp=${D}/${eclipse_dir}

	rm -rf ${bp}/plugins/org.eclipse.pde.source_3*
	rm -rf ${bp}/plugins/org.eclipse.jdt.source_3*
	rm -rf ${bp}/plugins/org.eclipse.platform.source.linux.*
	rm -rf ${bp}/plugins/org.eclipse.platform.source_3*

	rm -rf ${bp}/features/org.eclipse.jdt.source_3*/
	rm -rf ${bp}/features/org.eclipse.pde.source_3*/
	rm -rf ${bp}/features/org.eclipse.platform.source_3*/
}

function strip-docs() {
	local bp=${D}/${eclipse_dir}

	rm -rf ${bp}/plugins/org.eclipse.platform.doc.*
	rm -rf ${bp}/plugins/org.eclipse.jdt.doc.*
	rm -rf ${bp}/plugins/org.eclipse.pde.doc.*
}
