# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/eclipse-sdk/eclipse-sdk-3.0.1.ebuild,v 1.4 2005/03/23 16:16:48 seemant Exp $

inherit eutils java-utils

# karltk: Portage 2.0.51_pre13 needs this
MY_A="eclipse-sourceBuild-srcIncluded-3.0.1.zip"
DESCRIPTION="Eclipse Tools Platform"
HOMEPAGE="http://www.eclipse.org/"
SRC_URI="http://download2.eclipse.org/downloads/drops/R-3.0.1-200409161125/${MY_A}"
IUSE="gtk motif gnome kde mozilla"
SLOT="3"
LICENSE="CPL-1.0"
KEYWORDS="~x86 ~ppc"

RDEPEND="|| ( >=virtual/jdk-1.4.2 =dev-java/blackdown-jdk-1.4.2* )
	gtk? ( >=x11-libs/gtk+-2.2.4 )
	!gtk? (	kde? ( kde-base/kdelibs x11-libs/openmotif )
		!kde? ( motif? ( x11-libs/openmotif )
			!motif? ( >=x11-libs/gtk+-2.2.4 )
		      )
	      )
	mozilla? ( >=www-client/mozilla-1.5 )
	gnome? ( =gnome-base/gnome-vfs-2* =gnome-base/libgnomeui-2* )
	!media-fonts/unifont"

DEPEND="${RDEPEND}
	>=dev-java/ant-1.5.3
	>=sys-apps/findutils-4.1.7
	>=app-shells/tcsh-6.11
	app-arch/unzip
	app-arch/zip"

pkg_setup() {
	ewarn "This package is _highly_ experimental."
	ewarn "If you are using Eclipse 2.1.x for any serious work, stop now."
	ewarn "You cannot expect to be productive with this packaging of 3.0!"
	if use ppc; then
		ewarn "This package needs 1 gig Ram on PPC !"
	fi

	java-utils_setup-vm

	# karltk: refactor, put in java-pkg.eclass?
	local version="$(java-config --java-version | grep 'java version' | sed -r 's/java version \"(.*)\"/\1/')"
	local ver_rx="([0-9]+)\.([0-9]+)\.([0-9]+)(.*)"
	local major=$(echo ${version} | sed -r "s/${ver_rx}/\1/")
	local minor=$(echo ${version} | sed -r "s/${ver_rx}/\2/")
	local patch=$(echo ${version} | sed -r "s/${ver_rx}/\3/")
	local extra=$(echo ${version} | sed -r "s/${ver_rx}/\4/")

	if [ ${major} -ge 1 ] && [ ${minor} -gt 4 ] ; then
		einfo "Detected JDK is sufficient to compile Eclipse (${version} >= 1.4.2)"
	elif [ ${major} -ge 1 ] && [ ${minor} -ge 4 ] && [ ${patch} -ge 2 ] ; then
		einfo "Detected JDK is sufficient to compile Eclipse (${version} >= 1.4.2)"
	else
		die "Detected JDK (${version}) is too old to compile Eclipse, need at least 1.4.2!"
	fi

	if ${use_gtk} && use mozilla ; then
		if [ -f ${ROOT}/usr/lib/mozilla/libgtkembedmoz.so ] ; then
			einfo "Compiling against www-client/mozilla"
			mozilla_dir=/usr/lib/mozilla
		elif [ -f ${ROOT}/usr/lib/MozillaFirefox/libgtkembedmoz.so ] ; then
			einfo "Compiling against www-client/mozilla-firefox"
			mozilla_dir=/usr/lib/MozillaFirefox
		else
			eerror "You need either Mozilla, compiled against gtk+ v2.0 or newer"
			eerror "To merge it, do USE=\"gtk2\" emerge mozilla."
			eerror "Otherwise, remove \"mozilla\" from use flags"
			die "Need Mozilla compiled with gtk+-2.0 support"
		fi
	fi

	set_dirs
	use gtk && use_gtk='true' || use_gtk='false'
	use motif && use_motif='true' || use_motif='false'

	# If gtk+ enabled, disable motif
	${use_gtk} && use_motif='false'

	# If neither enabled, default to gtk+
	${use_gtk} || ${use_motif} || use_gtk='true'
}

set_dirs() {
	gtk_launcher_src_dir="plugins/platform-launcher/library/gtk"
	motif_launch_src_dir="plugins/platform-launcher/library/motif"
	gtk_swt_src_dir="plugins/org.eclipse.swt/Eclipse SWT PI/gtk/library"
	motif_swt_src_dir="plugins/org.eclipse.swt/Eclipse SWT PI/motif/library"

	core_src_dir="plugins/org.eclipse.core.resources.linux/src"

	case $ARCH in
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
	esac
}

src_unpack() {
	mkdir ${S}
	cd ${S}
	unpack ${MY_A} || die "Could not unpack ${MY_A}"

	epatch ${FILESDIR}/03-motif-java1.5-build.patch

	java-utils_setup-vm

	# Turn off verbose mode and on errors in all build.xml files
	for x in $(find . -type f -name "build.xml") ; do
		sed -i -r \
			-e 's/failonerror="[^"]+"/failonerror="true"/' \
			-e 's/verbose="[^"]+"/verbose="false"/' $x
	done

	# Clean up all pre-built code
	ant -q -DinstallWs=gtk -DinstallOs=linux clean
	ant -q -DinstallWs=motif -DinstallOs=linux clean
	find ${S} -name '*.so' -exec rm -f {} \;
	find ${S} -name '*.so.*' -exec rm -f {} \;
	find ${S} -type f -name 'eclipse' -exec rm {} \;
	rm -f eclipse

	# Move around some source code that should have been handled by the build system
	cd ${S}/"${gtk_swt_src_dir}" || die "Directory ${gtk_swt_src_dir} not found"
	cp ${S}/plugins/org.eclipse.swt/Eclipse\ SWT/common/library/* .
	cp ${S}/plugins/org.eclipse.swt/Eclipse\ SWT\ Mozilla/common/library/* .
	cp ${S}/plugins/org.eclipse.swt/Eclipse\ SWT\ Program/gnome/library/* .
	cp ${S}/plugins/org.eclipse.swt/Eclipse\ SWT\ AWT/gtk/library/* .

	if use gnome ; then
	    gnome_lib=`pkg-config --libs gnome-vfs-module-2.0 libgnome-2.0 libgnomeui-2.0 | sed -e "s:-pthread:-lpthread:" -e "s:-Wl,--export:--export:"`
	fi

	if ${use_gtk} ; then
		gtk_lib=`pkg-config --libs gtk+-2.0 gthread-2.0 | sed -e "s:-pthread:-lpthread:" -e "s:-Wl,--export:--export:"`
		atk_lib=`pkg-config --libs atk gtk+-2.0 | sed -e "s:-Wl,--export:--export:"`
	fi

	sed -e "s:/bluebird/teamswt/swt-builddir/IBMJava2-141:$JAVA_HOME:" \
		-e "s:/bluebird/teamswt/swt-builddir/jdk1.5.0:$JAVA_HOME:" \
		-e "s:/mozilla/mozilla/1.6/linux_gtk2/mozilla/dist:$MOZILLA_FIVE_HOME:" \
		-e "s:/usr/lib/mozilla-1.6:$MOZILLA_FIVE_HOME:" \
		-e "s:\`pkg-config --libs gtk+-2.0 gthread-2.0\`:${gtk_lib}:" \
		-e "s:\`pkg-config --libs atk gtk+-2.0\`:${atk_lib}:" \
		-e "s:\`pkg-config --libs gnome-vfs-module-2.0 libgnome-2.0 libgnomeui-2.0\`:${gnome_lib}:" \
		-e "s:-I\$(JAVA_HOME)/include:-I\$(JAVA_HOME)/include -I\$(JAVA_HOME)/include/linux:" \
		-e "s:-I\$(JAVA_HOME)\t:-I\$(JAVA_HOME)/include -I\$(JAVA_HOME)/include/linux:" \
		-e "s:-L\$(MOZILLA_HOME)/lib -lembed_base_s:-L${mozilla_dir} -lgtkembedmoz:" \
		-e "s:MOZILLACFLAGS = -O:MOZILLACFLAGS = -O -fPIC:" \
		-e "s:\$(JAVA_HOME)/jre/bin:\$(JAVA_HOME)/jre/lib/i386:" \
		-i make_gtk.mak

	cd ${S}/"${motif_swt_src_dir}"
	cp ${S}/plugins/org.eclipse.swt/Eclipse\ SWT/common/library/* .
	sed -e "s:/bluebird/teamswt/swt-builddir/IBMJava2-141:$JAVA_HOME:" \
		-e "s:/bluebird/teamswt/swt-builddir/motif21:/usr/X11R6:" \
		-e "s:/usr/lib/qt-3.1:/usr/qt/3:" \
		-e "s:-lkdecore:-L\`kde-config --prefix\`/lib -lkdecore:" \
		-e "s:-I/usr/include/kde:-I\`kde-config --prefix\`/include:" \
		-e "s:-I\$(JAVA_HOME)/include:-I\$(JAVA_HOME)/include -I\$(JAVA_HOME)/include/linux:" \
		-e "s:-I\$(JAVA_HOME)\t:-I\$(JAVA_HOME)/include -I\$(JAVA_HOME)/include/linux:" \
		-e "s:-L\$(MOZILLA_HOME)/lib -lembed_base_s:-L\$(MOZILLA_HOME):" \
		-e "s:-L\$(JAVA_HOME)/jre/bin:-L\$(JAVA_HOME)/jre/lib/i386:" \
		-i make_linux.mak

	cd ${S}
	find -type f -name about.mappings -exec sed -e "s/@build@/Gentoo Linux ${PF}/" -i \{\} \;
}

build_gtk_frontend() {

	einfo "Building gtk+ SWT"

	# Build the eclipse gtk binary
	cd ${S}/plugins/platform-launcher/library/gtk
	tcsh -f build.csh -output eclipse-gtk -arch $ARCH || die "Failed to build eclipse-gtk"

	cd ${S}/"${gtk_swt_src_dir}"
	make -f make_gtk.mak make_swt || die "Failed to build platform-independent SWT support"
	make -f make_gtk.mak make_atk || die "Failed to build atk support"

	if use gnome ; then
		einfo "Building GNOME VFS support"
		make -f make_gtk.mak make_gnome || die "Failed to build GNOME VFS support"
	fi

	if use mozilla ; then
		einfo "Building Mozilla component"
		make -f make_gtk.mak make_mozilla || die "Failed to build Mozilla support"
	fi

	# move the *.so files to the right path so eclipse can find them
	mkdir -p ${S}/"${gtk_swt_dest_dir}"
	mv *.so ${S}/"${gtk_swt_dest_dir}"
}

build_motif_frontend() {

	# Build eclipse motif binary
	cd ${S}/plugins/platform-launcher/library/motif
	tcsh -f build.csh -output eclipse-motif -arch $ARCH || die "Failed to build eclipse-motif"

	cd ${S}/"${motif_swt_src_dir}"

	make -f make_linux.mak make_swt || die "Failed to build Motif support"
	if use kde ; then
		make -f make_linux.mak make_kde || die "Failed to build KDE support"
	fi

	# move the *.so files to the right path so eclipse can find them
	mkdir -p ${S}/"${motif_swt_dest_dir}"
	mv *.so ${S}/"${motif_swt_dest_dir}"
}

src_compile() {

	addwrite "/proc/self/maps"
	addwrite "/proc/cpuinfo"
	addwrite "/dev/random"

	# Figure out correct boot classpath
	if [ ! -z "`java-config --java-version | grep IBM`" ] ; then
		# IBM JRE
		ant_extra_opts="-Dbootclasspath=$(java-config --jdk-home)/jre/lib/core.jar:$(java-config --jdk-home)/jre/lib/xml.jar:$(java-config --jdk-home)/jre/lib/graphics.jar"
	else
		# Sun derived JREs (Blackdown, Sun)
		ant_extra_opts="-Dbootclasspath=$(java-config --jdk-home)/jre/lib/rt.jar"
	fi

	export ANT_OPTS=-Xmx768m

	# Build selected frontends
	${use_gtk} && build_gtk_frontend
	${use_motif} && build_motif_frontend

	einfo "Building resources.core plugin"
	cd ${S}/${core_src_dir}
	make JDK_INCLUDE="`java-config -O`/include -I`java-config -O`/include/linux" || die "Failed to build resource.core plugin"
	mkdir -p ${S}/"${core_dest_dir}"
	mv *.so ${S}/"${core_dest_dir}"

	cd ${S}

	# Build all java code -- default to gtk if neither of gtk, motif,
	# kde are set
	if ( ${use_gtk} || ! ( ${use_gtk} || ${use_motif} || use kde ) ); then
		einfo "Building GTK+ frontend -- see compilelog.txt for details"
		ant -q -q \
			-buildfile build.xml \
			-DinstallOs=linux \
			-DinstallWs=gtk \
			-DinstallArch=$ARCH \
			${ant_extra_opts} compile install \
			|| die "Failed to compile java code (gtk+)"
	fi
	if ${use_motif} ; then
		einfo "Building Motif frontend -- see compilelog.txt for details"
		ant -q -q \
			-buildfile build.xml \
			-DcollPlace="eclipse-${SLOT}" \
			-DinstallOs=linux \
			-DinstallWs=motif \
			-DinstallArch=$ARCH \
			${ant_extra_opts} compile install \
			|| die "Failed to compile java code (Motif)"
	fi

	cat ${FILESDIR}/eclipse-${SLOT}.desktop | \
		sed -e "s/@PV@/${PV}/" \
		> eclipse-${SLOT}.desktop
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

	# Install GNOME .desktop file
	if use gnome ; then
		insinto /usr/share/gnome/apps/Development
		doins eclipse-${SLOT}.desktop
	fi

	# Install KDE .desktop file
	if use kde ; then
		# karltk: should check for available kde version(s)
		insinto /usr/kde/3.2/share/applnk/Applications/
		doins eclipse-${SLOT}.desktop
	fi

	doman ${FILESDIR}/eclipse.1
}
