# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/eclipse-sdk/eclipse-sdk-3.1_pre2.ebuild,v 1.3 2005/03/18 20:13:42 seemant Exp $

inherit eutils java-utils

# karltk: Portage 2.0.51_pre13 needs this
MY_A="eclipse-sourceBuild-srcIncluded-3.1M2.zip"
DESCRIPTION="Eclipse Tools Platform"
HOMEPAGE="http://www.eclipse.org/"
SRC_URI="http://download2.eclipse.org/downloads/drops/S-3.1M2-200409240800/${MY_A}"
IUSE="gtk motif gnome kde mozilla"
SLOT="3.1"
LICENSE="CPL-1.0"
KEYWORDS="~x86 ~ppc ~amd64"

RDEPEND="|| ( >=virtual/jdk-1.4.2 =dev-java/blackdown-jdk-1.4.2* )
	gtk? ( >=x11-libs/gtk+-2.2.4 )
	!gtk? (	kde? ( kde-base/kdelibs x11-libs/openmotif )
		!kde? ( motif? ( x11-libs/openmotif )
			!motif? ( >=x11-libs/gtk+-2.2.4 )
		      )
	      )
	mozilla? ( >=net-www/mozilla-1.5 )
	gnome? ( =gnome-base/gnome-vfs-2* =gnome-base/libgnomeui-2* )
	!media-fonts/unifont"

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

	${use_gtk} && use mozilla && detect-mozilla

	setup-dir-vars

	use gtk && use_gtk='true' || use_gtk='false'
	use motif && use_motif='true' || use_motif='false'

	# If gtk+ enabled, disable motif
	${use_gtk} && use_motif='false'

	# If neither enabled, default to gtk+
	${use_gtk} || ${use_motif} || use_gtk='true'

	# If both enabled, use gtk+ only
	${use_gtk} && ${use_motif} && use_motif='false'

	einfo "Compiling gtk+ frontend  : ${use_gtk}"
	einfo "Compiling Motif frontend : ${use_motif}"

}

src_unpack() {
	mkdir ${S}
	cd ${S}
	unpack ${MY_A} || die "Could not unpack ${MY_A}"

	einfo "Setting up virtual machine"
	java-utils_setup-vm

	einfo "Patching build.xmls"
	process-build-xmls

	einfo "Cleaning out prebuilt code"
	clean-prebuilt-code

	einfo "Patching gtk+ frontend"
	patch-gtk-frontend

	einfo "Patching Motif frontend"
	patch-motif-frontend

	einfo "Set build version in Help->About"
	find -type f -name about.mappings -exec sed -e "s/@build@/Gentoo Linux ${PF}/" -i \{\} \; \
		|| die "Failed to patch about.mappings"
}

src_compile() {

	# karltk: this should be handled by the java-pkg eclass in setup-vm 
	addwrite "/proc/self/maps"
	addwrite "/proc/cpuinfo"
	addwrite "/dev/random"

	# Figure out correct boot classpath
	# karltk: this should be handled by the java-pkg eclass in setup-vm
	if [ ! -z "`java-config --java-version | grep IBM`" ] ; then
		# IBM JRE
		ant_extra_opts="-Dbootclasspath=$(java-config --jdk-home)/jre/lib/core.jar:$(java-config --jdk-home)/jre/lib/xml.jar:$(java-config --jdk-home)/jre/lib/graphics.jar"
	else
		# Sun derived JREs (Blackdown, Sun)
		ant_extra_opts="-Dbootclasspath=$(java-config --jdk-home)/jre/lib/rt.jar"
	fi

	export ANT_OPTS=-Xmx768m

	einfo "Building resources.core plugin"
	cd ${S}/${core_src_dir}
	make JDK_INCLUDE="`java-config -O`/include -I`java-config -O`/include/linux" || die "Failed to build resource.core plugin"
	mkdir -p ${S}/"${core_dest_dir}"
	mv *.so ${S}/"${core_dest_dir}"
	cd ${S}

	# Build selected native frontend code
	${use_gtk} && build-gtk-native
	${use_motif} && build-motif-native

	# Compile all Java code
	${use_gtk} && build-gtk-java compile
	${use_motif} && build-motif-java compile

	# Install all Java code
	${use_gtk} && build-gtk-java install
	${use_motif} && build-motif-java install


	create-desktop-entry
}

src_install() {
	eclipse_dir="/usr/lib/eclipse-${SLOT}"

	dodir /usr/lib

	einfo "Installing features and plugins"
	if ${use_gtk} ; then
		[ -f result/linux-gtk-${ARCH}-sdk.zip ] || die "gtk zip bundle was not build properly!"
		unzip -o -q result/linux-gtk-${ARCH}-sdk.zip -d ${D}/usr/lib
	fi
	if ${use_motif} ; then
		[ -f result/linux-motif-${ARCH}-sdk.zip ] || die "motif zip bundle was not build properly!"
		unzip -o -q result/linux-motif-${ARCH}-sdk.zip -d ${D}/usr/lib
	fi

	mv ${D}/usr/lib/eclipse ${D}/${eclipse_dir}

	insinto ${eclipse_dir}

	# Install launchers and native code
	exeinto ${eclipse_dir}
	if ${use_gtk} ; then
		einfo "Installing eclipse-gtk binary"
		doexe plugins/platform-launcher/library/gtk/eclipse-gtk \
			|| die "Failed to install eclipse-gtk"
	fi
	if ${use_motif} ; then
		einfo "Installing eclipse-motif binary"
		doexe plugins/platform-launcher/library/motif/eclipse-motif \
			|| die "Failed to install eclipse-motif"
	fi

	doins plugins/org.eclipse.platform/{startup.jar,splash.bmp}

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
		einfo "Compiling against net-www/mozilla"
		mozilla_dir=/usr/lib/mozilla
	elif [ -f ${ROOT}/usr/lib/MozillaFirefox/libgtkembedmoz.so ] ; then
		einfo "Compiling against www-client/mozilla-firefox"
		mozilla_dir=/usr/lib/MozillaFirefox
	else
		eerror "You need either Mozilla, compiled against gtk+ v2.0 or newer"
		eerror "To merge it, do USE=\"gtk2\" emerge mozilla."
		eerror "Otherwise, remove \"mozilla\" from use flags"
		die "Need Mozilla compiled with gtk+-2.x support"
	fi
}

function setup-dir-vars() {
	gtk_launcher_src_dir="plugins/platform-launcher/library/gtk"
	motif_launch_src_dir="plugins/platform-launcher/library/motif"
	gtk_swt_src_dir="plugins/org.eclipse.swt/Eclipse SWT PI/gtk/library"
	motif_swt_src_dir="plugins/org.eclipse.swt/Eclipse SWT PI/motif/library"

	core_src_dir="plugins/org.eclipse.core.resources.linux/src"

	case ${ARCH} in
		sparc)
			gtk_swt_dest_dir="plugins/org.eclipse.swt.gtk/os/solaris/sparc"
			motif_swt_dest_dir="plugins/org.eclipse.swt.motif/os/solaris/sparc"
			core_dest_dir="plugins/org.eclipse.core.resources.linux/os/solaris/sparc"
			;;
		x86)
			gtk_swt_dest_dir="plugins/org.eclipse.swt.gtk/os/linux/x86"
			motif_swt_dest_dir="plugins/org.eclipse.swt.motif/os/linux/x86"
			core_dest_dir="plugins/org.eclipse.core.resources.linux/os/linux/x86"
			;;
		ppc)
			gtk_swt_dest_dir="plugins/org.eclipse.swt.gtk/os/linux/ppc"
			motif_swt_dest_dir="plugins/org.eclipse.swt.motif/os/linux/ppc"
			core_dest_dir="plugins/org.eclipse.core.resources.linux/os/linux/ppc/"
			;;
		amd64)
			gtk_swt_dest_dir="plugins/org.eclipse.swt.gtk64/os/linux/amd64"
			motif_swt_dest_dir="plugins/org.eclipse.swt.motif/os/linux/amd64"
			core_dest_dir="plugins/org.eclipse.core.resources.linux/os/linux/amd64"
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

function patch-gtk-frontend() {

	# Move around some source code that should have been handled by the build system
	local m="Failed to move native files for SWT gtk+"
	cp ${S}/plugins/org.eclipse.swt/Eclipse\ SWT/common/library/* ${S}/"${gtk_swt_src_dir}" || die ${m}
	cp ${S}/plugins/org.eclipse.swt/Eclipse\ SWT\ Mozilla/common/library/* ${S}/"${gtk_swt_src_dir}" || die ${m}
	cp ${S}/plugins/org.eclipse.swt/Eclipse\ SWT\ Program/gnome/library/* ${S}/"${gtk_swt_src_dir}" || die ${m}
	cp ${S}/plugins/org.eclipse.swt/Eclipse\ SWT\ AWT/gtk/library/* ${S}/"${gtk_swt_src_dir}" || die ${m}
	cp ${S}/plugins/org.eclipse.swt/Eclipse\ SWT\ Program/kde/library/* ${S}/"${gtk_swt_src_dir}" || die ${m}

	if use gnome ; then
	    gnome_lib=`pkg-config --libs gnome-vfs-module-2.0 libgnome-2.0 libgnomeui-2.0 | sed -e "s:-pthread:-lpthread:" -e "s:-Wl,--export:--export:"`
	fi

	if ${use_gtk} ; then
		gtk_lib="`pkg-config --libs gtk+-2.0 | sed -e 's:-pthread:-lpthread:' -e 's:-Wl,::'` -L/usr/X11R6/lib -lXtst"
		atk_lib=`pkg-config --libs atk gtk+-2.0 | sed -e "s:-Wl,--export:--export:"`
	fi

	sed -e "s:\`pkg-config --libs gtk+-2.0\`:${gtk_lib}:" \
		-e "s:\`pkg-config --libs atk gtk+-2.0\`:${atk_lib}:" \
		-e "s:\`pkg-config --libs gnome-vfs-module-2.0 libgnome-2.0 libgnomeui-2.0\`:${gnome_lib}:" \
		-e "s:-I\$(JAVA_HOME)/include:-I\$(JAVA_HOME)/include -I\$(JAVA_HOME)/include/linux:" \
		-e "s:-I\$(JAVA_HOME)\t:-I\$(JAVA_HOME)/include -I\$(JAVA_HOME)/include/linux:" \
		-e "s:-L\$(GECKO_SDK)/embed_base/bin -lembed_base_s:-L${mozilla_dir} -lgtkembedmoz:" \
		-e "s:\(^.*\)\(-L.*-lembedstring.*\)\(\\\\$\):\1\3:" \
		-e "s:\(^.*\)\(-L.*/xpcom/bin.*\)\(\\\\$\):\1\3:" \
		-e "s:\(^.*-L.*-lnspr4.*$\)::" \
		-e "s:MOZILLACFLAGS = -O:MOZILLACFLAGS = -O -DNO_nsEmbedString_1Equals -I${mozilla_dir}/include/java:" \
		-e "s:\(-include \)\(\$(GECKO_SDK)\)\(/mozilla-config.h\):\1${mozilla_dir}/include\3:" \
		-e "s:\(-I\$(GECKO_SDK)\)\(/.*\)\(/include\):-I${mozilla_dir}/include\2:g" \
		-e "s:\$(XTEST_LIB_PATH):/usr/X11R6/lib:" \
		-e "s:\$(GECKO_SDK):${mozilla_dir}:" \
		-e "s:/usr/include/kde:\`kde-config --prefix\`/include:" \
		-e "s:\(KDE_LIBS.*\)\(-L/usr/lib\):\1-L\`kde-config --prefix\`/lib:" \
		-i "${S}/${gtk_swt_src_dir}/make_linux.mak" || die "Failed to patch ${gtk_swt_src_dir}/make_linux.mak"


	sed -e "s:\(JAVA_HOME *=\)\(.*$\):\1${JAVA_HOME}:" \
		-e "s:\(GECKO_SDK *=\)\(.*$\):\1${mozilla_dir:-/usr/lib/mozilla}:" \
		-e "s:\(AWT_LIB_PATH *=\)\(.*$\):\1\$JAVA_HOME/jre/lib/${ARCH}:" \
		-i "${S}/${gtk_swt_src_dir}/build.sh" || die "Failed to patch ${gtk_swt_src_dir}/build.sh"

}

function patch-motif-frontend()
{
	local m="Failed to move native files for SWT Motif"

	cp plugins/org.eclipse.swt/Eclipse\ SWT/common/library/* ${S}/"${motif_swt_src_dir}" || die ${m}
	cp ${S}/plugins/org.eclipse.swt/Eclipse\ SWT\ Program/kde/library/* ${S}/"${motif_swt_src_dir}" || die ${m}

	sed -e "s:/bluebird/teamswt/swt-builddir/IBMJava2-141:$JAVA_HOME:" \
		-e "s:/bluebird/teamswt/swt-builddir/motif21:/usr/X11R6:" \
		-e "s:/usr/lib/qt-3.1:/usr/qt/3:" \
		-e "s:-lkdecore:-L\`kde-config --prefix\`/lib -lkdecore:" \
		-e "s:-I/usr/include/kde:-I\`kde-config --prefix\`/include:" \
		-e "s:-I\$(JAVA_HOME)/include:-I\$(JAVA_HOME)/include -I\$(JAVA_HOME)/include/linux:" \
		-e "s:-I\$(JAVA_HOME)\t:-I\$(JAVA_HOME)/include -I\$(JAVA_HOME)/include/linux:" \
		-e "s:-L\$(MOZILLA_HOME)/lib -lembed_base_s:-L\$(MOZILLA_HOME):" \
		-e "s:-L\$(JAVA_HOME)/jre/bin:-L\$(JAVA_HOME)/jre/lib/i386:" \
		-i "${motif_swt_src_dir}"/make_linux.mak || die "Failed to modify ${motif_swt_src_dir}/make_linux.mak"
}


function create-desktop-entry() {

	cat ${FILESDIR}/eclipse-${SLOT}.desktop | \
		sed -e "s/@PV@/${PV}/" \
		> eclipse-${SLOT}.desktop || die "Failed to create desktop entry"
}

function build-gtk-java() {
	local target=${1}

	einfo "Building GTK+ frontend (${target}) -- see compilelog.txt for details"
	ant -q -q  \
		-buildfile build.xml \
		-DcollPlace="eclipse-${SLOT}" \
		-DinstallOs=linux \
		-DinstallWs=gtk \
		-DinstallArch=$ARCH \
		${ant_extra_opts} ${target} \
		|| die "Failed to ${target} Java code (gtk+)"
}

function build-motif-java() {
	local target=${1}

	einfo "Building Motif frontend (${target}) -- see compilelog.txt for details"
	ant -q -q  \
		-buildfile build.xml \
		-DcollPlace="eclipse-${SLOT}" \
		-DinstallOs=linux \
		-DinstallWs=motif \
		-DinstallArch=$ARCH \
		${ant_extra_opts} ${target} \
		|| die "Failed to ${target} java code (Motif)"
}

function install-desktop-entry() {

	# Install GNOME .desktop file
	if use gnome ; then
		insinto /usr/share/gnome/apps/Development
		doins eclipse-${SLOT}.desktop
	fi

	# Install KDE .desktop file
	if use kde ; then
		for x in /usr/kde/* ; do
			insinto ${x}/share/applnk/Applications/
			doins eclipse-${SLOT}.desktop
		done
	fi
}

function build-gtk-native() {

	einfo "Building gtk+ SWT"

	# kludge to allow patches to applied at unpack, but correct compilation
	if [ ${ARCH} == "amd64" ] ; then
		gtk_swt_src_dir="plugins/org.eclipse.swt.gtk64/src/Eclipse SWT PI/gtk/library"
	fi

	# Perpare destination directory
	mkdir -p ${S}/"${gtk_swt_dest_dir}"

	# Build the eclipse gtk binary
	cd ${S}/plugins/platform-launcher/library/gtk
	case ${ARCH} in
		sparc|x86|ppc)
			bash ./build.sh -output eclipse-gtk -arch $ARCH || die "Failed to build eclipse-gtk"
			;;
		amd64)
			bash ./build.sh -output eclipse-gtk -arch $ARCH || die "Failed to build eclipse-gtk"
			;;
	esac


	cd ${S}/"${gtk_swt_src_dir}"
	case ${ARCH} in
		sparc|x86|ppc)
			bash ./build.sh make_swt || die "Failed to build platform-independent SWT support"
			bash ./build.sh make_atk || die "Failed to build atk support"
			;;
		amd64)
			bash ./build64.sh make_swt || die "Failed to build platform-independent SWT support"
			bash ./build64.sh make_atk || die "Failed to build atk support"
			;;
	esac

	if use gnome ; then
		einfo "Building GNOME VFS support"
		case ${ARCH} in
			sparc|x86|ppc)
				bash ./build.sh make_gnome || die "Failed to build GNOME VFS support"
				;;
			amd64)
				bash ./build64.sh make_gnome || die "Failed to build GNOME VFS support"
				;;
		esac
	fi

	if use kde ; then
		einfo "Building KDE support"
		bash ./build.sh make_kde || die "Failed to build KDE support"
	fi

	if use mozilla ; then
		einfo "Building Mozilla component"
		case $ARCH in
			sparc|x86|ppc)
				bash ./build.sh make_mozilla || die "Failed to build Mozilla support"
				;;
			amd64)
				bash ./build64.sh make_mozilla || die "Failed to build Mozilla support"
				;;
		esac
	fi

	# move the *.so files to the right path so eclipse can find them
	# karltk: do this incrementally at each step above, with || die
	mv *.so ${S}/"${gtk_swt_dest_dir}"
	cd ${S}

	einfo "Native gtk+ bindings built"
}

function build-motif-native() {

	einfo "Building Motif SWT"

	# Prepare destination directory
	mkdir -p ${S}/"${motif_swt_dest_dir}"

	# Build eclipse motif binary
	cd ${S}/plugins/platform-launcher/library/motif
	bash build.sh -output eclipse-motif -arch $ARCH || die "Failed to build eclipse-motif"

	cd ${S}/"${motif_swt_src_dir}"

	make -f make_linux.mak make_swt QT_HOME="${QTDIR}" || die "Failed to build Motif support"
	if use kde ; then
		make -f make_linux.mak make_kde QT_HOME="${QTDIR}" || die "Failed to build KDE support"
	fi

	# move the *.so files to the right path so eclipse can find them
	# karltk: do this incrementally at each step above, with || die
	mv *.so ${S}/"${motif_swt_dest_dir}"
	cd ${S}

	einfo "Native Motif bindings built"
}



function clean-prebuilt-code() {

	# Clean up all pre-built code
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
	dodir /usr/lib/eclipse-${SLOT}/links

	echo "path=/opt/eclipse-extensions-3" > ${D}/${eclipse_dir}/links/eclipse-binary-extensions-3.link
	echo "path=/opt/eclipse-extensions-3.1" > ${D}/${eclipse_dir}/links/eclipse-binary-extensions-3.1.link

	echo "path=/usr/lib/eclipse-extensions-3" > ${D}/${eclipse_dir}/links/eclipse-extensions-3.link
	echo "path=/usr/lib/eclipse-extensions-3.1" > ${D}/${eclipse_dir}/links/eclipse-extensions-3.1.link
}

function check-cflags() {
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
		ewarn "One or more potentially CFLAGS detected. When you run into trouble, please"
		ewarn "edit /etc/make.conf and remove all offending flags, then recompile"
		ewarn "Eclipse and all its dependencies before submitting a bug report."
		echo
		einfo "Tip: use equery depgraph \"=${PF}\" to list all dependencies"
		echo
		ebeep
	fi
}
