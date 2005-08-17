# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/swt/swt-3.1-r1.ebuild,v 1.2 2005/08/17 08:26:18 compnerd Exp $

inherit eutils java-pkg

MY_DMF="R-3.1-200506271435"
MY_VERSION="3.1"

DESCRIPTION="GTK based SWT Library"
HOMEPAGE="http://www.eclipse.org/"
SRC_URI="x86? ( http://download.eclipse.org/downloads/drops/${MY_DMF}/swt-${MY_VERSION}-gtk-linux-x86.zip )
		 amd64? ( http://download.eclipse.org/downloads/drops/${MY_DMF}/swt-${MY_VERSION}-gtk-linux-x86_64.zip )
		 ppc? ( http://download.eclipse.org/downloads/drops/${MY_DMF}/swt-${MY_VERSION}-gtk-linux-ppc.zip )"

SLOT="3"
LICENSE="CPL-1.0 LGPL-2.1 MPL-1.1"
KEYWORDS="~x86 ~amd64 ~ppc"

IUSE="accessibility cairo firefox gnome mozilla"
RDEPEND=">=virtual/jre-1.4
		 mozilla? (
		 			 firefox? ( >=www-client/mozilla-firefox-1.0.3 )
					!firefox? ( >=www-client/mozilla-1.4 )
				  )
		 gnome? ( =gnome-base/gnome-vfs-2* =gnome-base/libgnomeui-2* )
		 cairo? ( >=x11-libs/cairo-0.3.0 )"
DEPEND=">=virtual/jdk-1.4
		${RDEPEND}
		  dev-util/pkgconfig
		  dev-java/ant-core
		  app-arch/unzip"

S=${WORKDIR}

pkg_setup() {
	if use firefox ; then
		if ! use mozilla ; then
			echo
			ewarn "You must enable the mozilla useflag to build the browser"
			ewarn "component.  The firefox flag is used only to determine"
			ewarn "what to build against."

			die "Firefox useflag enabled without mozilla support"
		fi
	fi
}

src_unpack() {
	# Extract based on architecture
	if [[ ${ARCH} == 'amd64' ]] ; then
		unpack swt-${MY_VERSION}-gtk-linux-x86_64.zip || die "Unable to unpack sources"
	elif [[ ${ARCH} == 'ppc' ]] ; then
		unpack swt-${MY_VERSION}-gtk-linux-ppc.zip || die "Unable to unpack	sources"
	else
		unpack swt-${MY_VERSION}-gtk-linux-x86.zip || die "Unable to unpack	sources"
	fi

	# Clean up the directory structure
	for f in $(ls); do
		if [[ "${f}" != "src.zip" ]] ; then
			rm -rf ${f}
		fi
	done

	# Unpack the sources
	echo "Unpacking src.zip to ${S}"
	unzip src.zip &> /dev/null || die "Unable to extract sources"

	# Cleanup the redirtied directory structure
	rm -rf about_files/
	rm -f .classpath .project

	# Replace the build.xml to allow compilation without Eclipse tasks
	cp ${FILESDIR}/build.xml ${S}/build.xml || die "Unable to update build.xml"
	mkdir ${S}/src && mv ${S}/org ${S}/src || die "Unable to restructure SWT sources"
}

src_compile() {
	JAVA_HOME=$(java-config -O)

	# Identify the AWT path
	if [[ ! -z "$(java-config --java-version | grep 'IBM')" ]] ; then
		export AWT_LIB_PATH=$JAVA_HOME/jre/bin
	else
		if [[ ${ARCH} == 'x86' ]] ; then
			export AWT_LIB_PATH=$JAVA_HOME/jre/lib/i386
		elif [[ ${ARCH} == 'ppc' ]] ; then
			export AWT_LIB_PATH=$JAVA_HOME/jre/lib/ppc
		else
			export AWT_LIB_PATH=$JAVA_HOME/jre/lib/amd64
		fi
	fi

	# Identity the XTEST library location
	export XTEST_LIB_PATH=/usr/X11R6/lib

	# Fix the pointer size for AMD64
	[[ ${ARCH} == 'amd64' ]] && export SWT_PTR_CFLAGS=-DSWT_PTR_SIZE_64

	einfo "Building AWT library"
	emake -f make_linux.mak make_awt || die "Failed to build AWT support"

	einfo "Building SWT library"
	emake -f make_linux.mak make_swt || die "Failed to build SWT support"

	if use accessibility ; then
		einfo "Building JAVA-AT-SPI bridge"
		emake -f make_linux.mak make_atk || die "Failed to build ATK support"
	fi

	if use gnome ; then
		einfo "Building GNOME VFS support"
		emake -f make_linux.mak make_gnome || die "Failed to build GNOME VFS support"
	fi

	if use mozilla ; then
		if use firefox ; then
			GECKO_SDK="$(pkg-config firefox-xpcom --variable=libdir)"
		else
			GECKO_SDK="$(pkg-config mozilla-xpcom --variable=libdir)"
		fi

		export GECKO_INCLUDES="-include ${GECKO_SDK}/include/mozilla-config.h \
						-I${GECKO_SDK}/include \
						-I${GECKO_SDK}/include/java \
						-I${GECKO_SDK}/include/nspr -I${GECKO_SDK}/include/nspr/include \
						-I${GECKO_SDK}/include/xpcom -I${GECKO_SDK}/include/xpcom/include \
						-I${GECKO_SDK}/include/string -I${GECKO_SDK}/include/string/include \
						-I${GECKO_SDK}/include/embed_base -I${GECKO_SDK}/include/embed_base/include \
						-I${GECKO_SDK}/include/embedstring -I${GECKO_SDK}/include/embedstring/include"
		export GECKO_LIBS="-L${GECKO_SDK} -lgtkembedmoz"

		einfo "Building the Mozilla component"
		emake -f make_linux.mak make_mozilla || die "Failed to build Mozilla support"
	fi

	if use cairo ; then
		einfo "Building CAIRO support"
		emake -f make_linux.mak make_cairo || die "Unable to build CAIRO support"
	fi

	einfo "Building JNI libraries"
	ant compile || die "Failed to compile JNI interfaces"

	einfo "Creating missing files"
	echo "version 3.138" > ${S}/build/version.txt
	cp ${FILESDIR}/SWTMessages.properties ${S}/build/org/eclipse/swt/internal/

	einfo "Packing JNI libraries"
	ant jar || die "Failed to create JNI jar"
}

src_install() {
	java-pkg_dojar swt.jar

	java-pkg_sointo /usr/lib
	java-pkg_doso *.so

	dohtml about.html
}

pkg_postinst() {
	if use cairo; then
		ewarn
		ewarn "CAIRO Support is experimental! We are not responsible if"
		ewarn "enabling support for CAIRO corrupts your Gentoo install,"
		ewarn "if it blows up your computer, or if it becoming sentient"
		ewarn "and chases you down the street yelling random binary!"
		ewarn
		ebeep 5
	fi
}
