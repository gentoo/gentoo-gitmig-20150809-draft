# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/eclipse-sdk/eclipse-sdk-2.1.3-r5.ebuild,v 1.2 2004/07/31 23:34:49 karltk Exp $

inherit eutils

DESCRIPTION="Eclipse Tools Platform"
HOMEPAGE="http://www.eclipse.org/"
SRC_URI="http://download.eclipse.org/downloads/drops/R-2.1.3-200403101828/eclipse-sourceBuild-srcIncluded-2.1.3.zip"
IUSE="gnome gtk jikes kde motif mozilla"
SLOT="2"
LICENSE="CPL-1.0"
KEYWORDS="~x86 ~ppc ~sparc"

RDEPEND=">=virtual/jdk-1.3
        gtk? ( >=x11-libs/gtk+-2.2.4 )
        !gtk? ( kde? ( kde-base/kdelibs x11-libs/openmotif )
                !kde? ( motif? ( x11-libs/openmotif )
                        !motif? ( >=x11-libs/gtk+-2.2.4 )
                      )
              )
	gnome? ( =gnome-base/gnome-vfs-2* )
	mozilla? ( net-www/mozilla )
	jikes? ( >=dev-java/jikes-1.19 )
	"

DEPEND="${RDEPEND}
	>=dev-java/ant-1.5.3
	>=sys-apps/findutils-4.1.7
	>=app-shells/tcsh-6.11
	app-arch/unzip"

pkg_setup() {


	set_dirs

	use gtk && use_gtk='true' || use_gtk='false'
	use motif && use_motif='true' || use_motif='false'

	# If gtk+ enabled, disable motif
	${use_gtk} && use_motif='false'

	# If neither enabled, default to gtk+
	if ! ( ${use_gtk} || ${use_motif} ) ; then
		if use kde ; then
			use_motif='true'
		else
			use_gtk='true'
		fi
	fi
}

set_dirs() {
	gtk_launcher_src_dir="plugins/platform-launcher/library/gtk"
	motif_launch_src_dir="plugins/platform-launcher/library/motif"
	gtk_swt_src_dir="plugins/org.eclipse.swt/Eclipse SWT PI/gtk/library"
	motif_swt_src_dir="plugins/org.eclipse.swt/Eclipse SWT PI/motif/library"

	core_src_dir="plugins/org.eclipse.core.resources.linux/src"

	case $ARCH in
		sparc)
			gtk_swt_dest_dir="plugins/org.eclipse.swt.gtk/os/linux/sparc"
			motif_swt_dest_dir="plugins/org.eclipse.swt.motif/os/linux/sparc"
			core_dest_dir="plugins/org.eclipse.core.resources.linux/os/linux/sparc"
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
	unpack ${A}

	epatch ${FILESDIR}/00-refactor_rename.patch
	epatch ${FILESDIR}/01-distribute_ant_target-2.1.patch

	if use kde ; then
		epatch ${FILESDIR}/02-konqueror_help_browser-2.1.patch
	fi

	# Clean up all pre-built code
	ant -q -Dws=gtk -Dos=linux clean
	ant -q -Dws=motif -Dos=linux clean
	find ${S} -name '*.so' -exec rm -f {} \;
	find ${S} -name '*.so.*' -exec rm -f {} \;
	find ${S} -type f -name 'eclipse' -exec rm {} \;
	rm -f eclipse


	if ${use_gtk} ; then
		einfo "Fixing gtk+ build scripts"

		# Move around some source code that should have been handled by the build system
		cd ${S}/"${gtk_swt_src_dir}" || die "Directory ${gtk_swt_src_dir} not found"
		cp ${S}/plugins/org.eclipse.swt/Eclipse\ SWT/common/library/* .

		# Configure libraries for GNOME and GTK+
		if use gnome ; then
			gnome_lib=`pkg-config --libs gnome-vfs-module-2.0 libgnome-2.0 libgnomeui-2.0 | sed -e "s:-pthread:-lpthread:" -e "s:-Wl,--export:--export:"`
		fi

		gthread_lib=`pkg-config --libs gtk+-2.0 gthread-2.0 | sed -e "s:-pthread:-lpthread:" -e "s:-Wl,--export:--export:"`

		sed -e "s:/bluebird/teamswt/swt-builddir/ive:$JAVA_HOME:" \
			-e "s:JAVA_JNI=\$(IVE_HOME)/bin/include:JAVA_JNI=\$(IVE_HOME)/include:" \
			-e "s:\`pkg-config --libs gthread-2.0\`:${gthread_lib}:" \
			-e "s:\`pkg-config --libs gnome-vfs-2.0\`:${gnome_lib}:" \
			-e "s:-I\$(JAVA_JNI):-I\$(JAVA_JNI) -I\$(JAVA_JNI)/linux:" \
			-i make_gtk.mak

		# Extra patching if the gtk+ installed is 2.4 or newer
		# for users with the 2.3 series, they should upgrade, dunno which 2.3.x all this
		#  stuff broke in anyway.
		if pkg-config --atleast-version 2.4 gtk+-2.0 ; then
			einfo "Applying gtk+-2.4 patches"
			sed -r \
				-e "s:#define GTK_DISABLE_DEPRECATED::g" \
				-i swt.c
		fi
	fi

	if ${use_motif} ; then
		einfo "Fixing motif build scripts"

		# Some fixups for the motif compilation
		cd ${S}/"${motif_swt_src_dir}"
		cp ${S}/plugins/org.eclipse.swt/Eclipse\ SWT/common/library/* .

		sed -e "s:/bluebird/teamswt/swt-builddir/ive/bin:$JAVA_HOME:" \
			-e "s:-I\$(JAVA_HOME)/include:-I\$(JAVA_HOME)/include -I\$(JAVA_HOME)/include/linux:" \
			-e "s:/bluebird/teamswt/swt-builddir/motif21:/usr/X11R6:" \
			-e "s:\`pkg-config --libs gthread-2.0\`:${gthread_lib}:" \
			-e "s:\`pkg-config --libs gnome-vfs-2.0\`:${gnome_lib}:" \
			-e "s:/usr/lib/qt3:/usr/qt/3:" \
			-e "s:-lkdecore:-L\`kde-config --prefix\`/lib -lkdecore:" \
			-e "s:-I/usr/include/kde:-I\`kde-config --prefix\`/include:" \
		-i make_linux.mak
	fi

	# Patch in package version into the build info
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

	# move the *.so files to the right path so eclipse can find them
	mkdir -p ${S}/"${gtk_swt_dest_dir}"
	mv *.so ${S}/"${gtk_swt_dest_dir}"
}

build_motif_frontend() {

	einfo "Building Motif SWT"

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

	# Figure out correct boot classpath
	if [ ! -z "`java-config --java-version | grep IBM`" ] ; then
		# IBM JRE
		einfo "Using the IBM JDK"
		ant_extra_opts="-Dbootclasspath=$(java-config --jdk-home)/jre/lib/core.jar"
	else
		# Sun derived JREs (Blackdown, Sun)
		ant_extra_opts="-Dbootclasspath=$(java-config --jdk-home)/jre/lib/rt.jar"
	fi

	# karltk: jikes doesn't work as a compiler for Eclipse currently
#	if use jikes ; then
#		ant_extra_opts="${ant_extra_opts} -Dbuild.compiler=jikes"
#	fi

	export ANT_OPTS=-Xmx768m

	# Build resources
	einfo "Building resources.core plugin"
	cd ${core_src_dir}
	make JDK_INCLUDE="`java-config -O`/include -I`java-config -O`/include/linux" || die "Failed to build resource.core plugin"
	mkdir -p ${S}/"${core_dest_dir}"
	mv *.so ${S}/"${core_dest_dir}"


	einfo "Building selected platform"
	cd ${S}
	${use_gtk} && build_gtk_frontend
	${use_motif} && build_motif_frontend

	einfo "Building java code"
	# karltk: Do we really need to rebuild all of this if both motif and
	# gtk are specified?
	cd ${S}
	if ( ${use_gtk} || ! ( ${use_gtk} || ${use_motif} || use kde ) ); then
		einfo "Building platform suited for the GTK+ frontend"
		ant -q \
			-buildfile build.xml \
			-Dos=linux \
			-Dws=gtk \
			-DinstallArch=$ARCH \
			${ant_extra_opts} compile distribute || die "Failed to compile java code (gtk+)"
	fi
	if ${use_motif} ; then
		einfo "Building platform suited for the Motif frontend"
		ant -q \
			-buildfile build.xml \
			-Dos=linux \
			-Dws=motif \
			-DinstallArch=$ARCH \
			${ant_extra_opts} compile distribute || die "Failed to compile java code (Motif)"
	fi

	cat ${FILESDIR}/eclipse-${SLOT}.desktop | \
		sed -e "s/@PV@/${PV}/" \
		> eclipse-${SLOT}.desktop
}

src_install() {
	eclipse_dir="/usr/lib/eclipse-${SLOT}"

	# Create basic directories
	dodir ${eclipse_dir}

	einfo "Installing features and plugins"
	find features \
		-name "*.bin.dist.zip" \
		-exec unzip -q -o \{\} -d ${D}/${eclipse_dir} \;

	# Install launchers and native code
	exeinto ${eclipse_dir}
	if ${use_gtk} ; then
		einfo "Installing eclipse-gtk binary"
		doexe plugins/platform-launcher/library/gtk/eclipse-gtk || die "Failed to install eclipse-gtk"
	fi
	if ${use_motif} ; then
		einfo "Installing eclipse-motif binary"
		doexe plugins/platform-launcher/library/motif/eclipse-motif || die "Failed to install eclipse-motif"
	fi

	# Installing misc files
	insinto ${eclipse_dir}
	doins plugins/org.eclipse.platform/.eclipseproduct || die "Missing .eclipseproduct"
	doins plugins/org.eclipse.platform/{startup.jar,splash.bmp} || die "Missing startup,jar or splash.bmp"
	doins plugins/platform-launcher/bin/linux/gtk/icon.xpm || die "Missing icon.xpm"
	doins plugins/org.eclipse.platform/install.ini || die "Missing install.ini"

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
