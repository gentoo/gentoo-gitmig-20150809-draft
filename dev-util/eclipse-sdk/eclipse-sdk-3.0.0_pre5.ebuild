# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/eclipse-sdk/eclipse-sdk-3.0.0_pre5.ebuild,v 1.2 2004/01/07 20:28:39 mr_bones_ Exp $

DESCRIPTION="Eclipse Tools Platform"
HOMEPAGE="http://www.eclipse.org/"
SRC_URI="http://download2.eclipse.org/downloads/drops/S-3.0M5-200311211210/eclipse-sourceBuild-srcIncluded-3.0M5.zip"
IUSE="gtk motif gnome kde mozilla"

SLOT="0"
LICENSE="CPL-1.0"
KEYWORDS="~x86 ~ppc ~sparc"

DEPEND="${RDEPEND}
	>=dev-java/ant-1.5.3
	>=sys-apps/findutils-4.1.7
	>=app-shells/tcsh-6.11
	app-arch/unzip"

# removed since the bin lives in /opt and this in /usr
#	!dev-util/eclipse-platform-bin
#	!dev-util/eclipse-jdt-bin
#	!dev-util/eclipse-cdt-bin"

RDEPEND=">=virtual/jdk-1.3
	kde? ( kde-base/kde virtual/motif ) :
		( gnome? ( =gnome-base/gnome-vfs-2* ) :
		( motif? ( virtual/motif ) :
		( >=x11-libs/gtk+-2.2.1-r1 ) ) )
	motif? ( virtual/motif )
	gnome? ( =gnome-base/gnome-vfs-2* )
	gtk? ( >=x11-libs/gtk+-2.2.1-r1 )
	mozilla? ( >=net-www/mozilla-1.5 )"

S=${WORKDIR}/eclipse

pkg_setup() {
	ewarn "This package is _highly_ experimental."
	ewarn "If you are using Eclipse 2.1.x for any serious work, stop now."
	ewarn "You cannot expect to be productive with this packaging of 3.0!"
	echo -ne "\a" ; sleep 0.1 &>/dev/null ; sleep 0,1 &>/dev/null
	echo -ne "\a" ; sleep 1
	echo -ne "\a" ; sleep 0.1 &>/dev/null ; sleep 0,1 &>/dev/null
	echo -ne "\a" ; sleep 1
	echo -ne "\a" ; sleep 0.1 &>/dev/null ; sleep 0,1 &>/dev/null
	sleep 5
	ewarn "You have been warned...."
}
src_unpack() {
	unpack ${A}
}

src_compile() {

	# This ebuild is doing some slightly funky things since the
	# source tarball also contains all the binaries for eclipse.  On
	# top of this, there are a ton of files that need to be merged
	# so instead of specifying all these files, we're instead
	# removing all the extra fluff from the source tree and then
	# merging it all over when we're done.

	# This ebuild will compile eclipse for gtk2, motif, and kde
	# toolkits depending on the use flags set.  If all are set, the
	# default version linked to is the GTK2 version.  When building
	# for KDE though, the motif version must be built with support
	# for KDE.  Apparently the motif build also supports KDE when
	# this is done - I could be wrong though.

	gtk_launcher_src_dir="${WORKDIR}/plugins/platform-launcher/library/gtk"
	motif_launch_src_dir="${WORKDIR}/plugins/platform-launcher/library/motif"
	gtk_swt_src_dir=${WORKDIR}/plugins/org.eclipse.swt/Eclipse\ SWT\ PI/gtk/library
	motif_swt_src_dir=${WORKDIR}/plugins/org.eclipse.swt/Eclipse\ SWT\ PI/motif/library

	case $ARCH in
		sparc)
			gtk_swt_dest_dir="${WORKDIR}/plugins/org.eclipse.swt.gtk/os/solaris/sparc"
			motif_swt_dest_dir="${WORKDIR}/plugins/org.eclipse.swt.motif/os/solaris/sparc"
			;;
		x86)
			gtk_swt_dest_dir="${WORKDIR}/plugins/org.eclipse.swt.gtk/os/linux/x86"
			motif_swt_dest_dir="${WORKDIR}/plugins/org.eclipse.swt.motif/os/linux/x86"
			;;
		ppc)
			gtk_swt_dest_dir="${WORKDIR}/plugins/org.eclipse.swt.gtk/os/linux/ppc"
			motif_swt_dest_dir="${WORKDIR}/plugins/org.eclipse.swt.motif/os/linux/ppc"
			;;
	esac

	use gtk && gtk=y
	use motif && motif=y
	use gnome && gnome=y gtk=y
	use mozilla && mozilla=y
	use kde && kde=y motif=y

	# force gtk to be the default if motif isn't selected
	if ! [ ${motif} = "y" ] ; then
		gtk=y
	fi

	cd ${WORKDIR}

	# First build all java code

	# this export is pulled from the build shellscript supplied by
	# eclipse. It fixes an outOfMemory exception during the ant build
	# process.
	export ANT_OPTS=-Xmx768m

	if [ "${gtk}" = "y" ] ; then
		einfo "Building GTK+ frontend"
		ant -buildfile build.xml -DinstallOs=linux -DinstallWs=gtk -DinstallArch=$ARCH -Dbootclasspath=$JAVA_HOME/jre/lib/rt.jar -DjavacTarget=1.2 compile
	fi
	if [ "${motif}" = "y" ] ; then
		einfo "Building Motif frontend"
		ant -buildfile build.xml -DinstallOs=linux -DinstallWs=motif -DinstallArch=$ARCH -Dbootclasspath=$JAVA_HOME/jre/lib/rt.jar -DjavacTarget=1.2 compile
	fi

	# remove all .so files shipped with the tarball
	find ${WORKDIR} -name '*.so' -exec rm -f {} \;

	# remove the eclipse binary copied from the ant build above.
	rm -f ${WORKDIR}/eclipse


	# I'm replacing these pkg-config lines since --libs for them
	# returns -pthread instead of -lpthread and remove the -Wl, since
	# ld doesn't know what to do with it.

	GTK_LIB=`pkg-config --libs gtk+-2.0 gthread-2.0 | sed -e "s:-pthread:-lpthread:" -e "s:-Wl,--export:--export:"`
	ATK_LIB=`pkg-config --libs atk gtk+-2.0 | sed -e "s:-Wl,--export:--export:"`
	GNOME_LIB=`pkg-config --libs gnome-vfs-module-2.0 libgnome-2.0 | sed -e "s:-pthread:-lpthread:" -e "s:-Wl,--export:--export:"`

	# Build for the gtk toolkit
	if [ "${gtk}" = "y" ] ; then
		# Build the eclipse gtk binary
		cd ${WORKDIR}/plugins/platform-launcher/library/gtk
		tcsh build.csh -arch $ARCH || die
		mv eclipse ${WORKDIR}/eclipse-gtk

		cd "${gtk_swt_src_dir}"
		cp ${WORKDIR}/plugins/org.eclipse.swt/Eclipse\ SWT/common/library/* .
		cp ${WORKDIR}/plugins/org.eclipse.swt/Eclipse\ SWT\ Mozilla/common/library/* .

		cp make_gtk.mak make_gtk.mak.orig
		sed -e "s:/bluebird/teamswt/swt-builddir/ive/bin:$JAVA_HOME:" \
	    	-e "s:/mozilla/mozilla/1.5/linux_gtk2/mozilla/dist:$MOZILLA_FIVE_HOME:" \
	    	-e "s:/usr/lib/mozilla-1.5:$MOZILLA_FIVE_HOME:" \
	    	-e "s:\`pkg-config --libs gtk+-2.0 gthread-2.0\`:${GTK_LIB}:" \
	    	-e "s:\`pkg-config --libs atk gtk+-2.0\`:${ATK_LIB}:" \
		    -e "s:\`pkg-config --libs gnome-vfs-module-2.0 libgnome-2.0\`:${GNOME_LIB}:" \
		    -e "s:-I\$(JAVA_HOME)/include:-I\$(JAVA_HOME)/include -I\$(JAVA_HOME)/include/linux:" \
		    -e "s:-I\$(JAVA_HOME)\t:-I\$(JAVA_HOME)/include -I\$(JAVA_HOME)/include/linux:" \
		    -e "s:-L\$(MOZILLA_HOME)/lib -lembed_base_s:-L\$(MOZILLA_HOME):" \
		make_gtk.mak.orig > make_gtk.mak

		make -f make_gtk.mak make_swt
		make -f make_gtk.mak make_atk
		if [ "${gnome}" = "y" ] ; then
			make -f make_gtk.mak make_gnome
		fi
		if [ "${mozilla}" = "y" ] ; then
			einfo "Building Mozilla component"
			make -f make_gtk.mak make_mozilla
		fi

		# move the *.so files to the right path so eclipse can find them
		mkdir "${gtk_swt_dest_dir}"
		mv *.so "${gtk_swt_dest_dir}"
		make -f make_gtk.mak clean   #do a clean since everything is going to end up getting merged

		# Build the install .zip
		cd ${WORKDIR}
		ant -buildfile build.xml -DinstallOs=linux -DinstallWs=gtk -DinstallArch=$ARCH -Dbootclasspath=$JAVA_HOME/jre/lib/rt.jar -DjavacTarget=1.2 install
	fi

	# Build for the motif toolkit
	if [ "${motif}" = "y" ] ; then
		# Build the eclipse motif binary
		cd ${WORKDIR}/plugins/platform-launcher/library/motif
		tcsh build.csh -arch $ARCH || die
		mv eclipse ${WORKDIR}/eclipse-motif

		cd "${motif_swt_src_dir}"
		cp ${WORKDIR}/plugins/org.eclipse.swt/Eclipse\ SWT/common/library/* .

		mv make_linux.mak make_linux.mak.orig
		sed -e "s:/bluebird/teamswt/swt-builddir/IBMJava2-141:$JAVA_HOME:" \
			-e "s:/bluebird/teamswt/swt-builddir/motif21:/usr/X11R6:" \
			-e "s:/usr/lib/qt-3.1:/usr/qt/3:" \
			-e "s:-lkdecore:-L\`kde-config --prefix\`/lib -lkdecore:" \
			-e "s:-I/usr/include/kde:-I\`kde-config --prefix\`/include:" \
			-e "s:-L\$(JAVA_HOME)/jre/bin:-L\$(JAVA_HOME)/jre/lib/i386" \
		make_linux.mak.orig > make_linux.mak

		make -f make_linux.mak make_swt

#		Currently disabled - need to fix the path above for the library path
#		to NOT be x86 specific
#		make -f make_linux.mak make_awt

		if [ "${gnome}" = "y" ] ; then
			make -f make_linux.mak make_gnome
		fi
		if [ "${kde}" = "y" ] ; then
			make -f make_linux.mak make_kde
		fi

		# move the *.so files to the right path so eclipse can find them
		mkdir "${motif_swt_dest_dir}"
		mv *.so "${motif_swt_dest_dir}"
		make -f make_linux.mak clean   #do a clean since everything is going to end up getting merged

		# Build the install .zip
		cd ${WORKDIR}
		ant -buildfile build.xml -DinstallOs=linux -DinstallWs=motif -DinstallArch=$ARCH -Dbootclasspath=$JAVA_HOME/jre/lib/rt.jar -DjavacTarget=1.2 install
	fi

}

src_install() {
	cd ${WORKDIR}

	exeinto /usr/bin
	doexe ${FILESDIR}/eclipse

	dodir /usr/lib/eclipse
	exeinto /usr/lib/eclipse

	if [ -f eclipse-gtk ] ; then
		doexe eclipse-gtk
		dosym /usr/lib/eclipse/eclipse-gtk /usr/lib/eclipse/eclipse
	fi
	if [ -f eclipse-motif ] ; then
		doexe eclipse-motif
		dosym /usr/bin/eclipse /usr/bin/eclipse-motif
		if ! [ -f eclipse-gtk ] ; then
			dosym /usr/lib/eclipse/eclipse-motif /usr/lib/eclipse/eclipse
		fi
	fi

	cd ${WORKDIR}/result
	if [ "${gtk}" = "y" ] ; then
		unzip linux-gtk-${ARCH}-sdk.zip
	fi
	if [ "${motif}" = "y" ] ; then
		unzip linux-motif-${ARCH}-sdk.zip
	fi

	cd ${WORKDIR}/result/eclipse
	cp -dpR features icon.xpm install.ini plugins startup.jar \
		${D}/usr/lib/eclipse/
	dodoc cpl-v10.html notice.html readme/readme_eclipse.html

	insinto /usr/share/gnome/apps/Development
	doins ${FILESDIR}/eclipse.desktop
}
