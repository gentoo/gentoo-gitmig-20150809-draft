# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/swt/swt-3.1_pre5-r1.ebuild,v 1.1 2005/05/24 17:52:54 compnerd Exp $

inherit eutils java-pkg

MY_DMF="S-3.1M5a-200502191500"
MY_VERSION="3.1M5a"

DESCRIPTION="GTK based SWT Library"
HOMEPAGE="http://www.eclipse.org/"
SRC_URI="x86? (  http://download.eclipse.org/downloads/drops/${MY_DMF}/swt-${MY_VERSION}-linux-gtk.zip )
		 amd64? ( http://download.eclipse.org/downloads/drops/${MY_DMF}/swt-${MY_VERSION}-linux-gtk-x86_64.zip )"

SLOT="3.1"
LICENSE="CPL-1.0 LGPL-2.1 MPL-1.1"
KEYWORDS="~x86 ~amd64"

IUSE="accessibility cairo firefox gnome mozilla"
DEPEND="${RDEPEND}
		>=virtual/jdk-1.4
		  dev-java/ant-core
		  app-arch/unzip"
RDEPEND=">=virtual/jre-1.4
		 mozilla? (
		 			firefox? ( >=www-client/mozilla-firefox-1.0.3 )
					!firefox? ( >=www-client/mozilla-1.4 )
				  )
		 gnome? ( =gnome-base/gnome-vfs-2* =gnome-base/libgnomeui-2* )
		 cairo? ( >=x11-libs/cairo-0.3.0 )"

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
	if [[ ${ARCH} == 'x86' ]] ; then
		unpack swt-${MY_VERSION}-linux-gtk.zip
	else
		unpack swt-${MY_VERSION}-linux-gtk-x86_64.zip
	fi

	# Clean up the directory structure
	rm -r *.so *.jar
	rm cpl-v10.html lgpl-v21.txt mpl-v11.txt

	# We still need to have the JNI interfaces for these
	# use mozilla || rm -f swt-mozillasrc.zip
	# use cairo || rm -f swt-cairosrc.zip

	# Unpack the sources
	for i in $(ls *.zip) ; do
		einfo "Unpacking ${i} to ${S}"
		unzip $i &> /dev/null || die "Unable to extract sources"
	done

	# Take the XPCOM objects from the library code if we build the Mozilla
	# Component
	if use mozilla ; then
		cp library/xpcom* ${S} || die "Unable to find sources for mozilla component."
	fi

	# Copy the cairo sources for compiling the cairo component
	if use cairo ; then
		cp library/cairo* ${S} || die "Unable to find sources for CAIRO component."
	fi

	# Replace the build.xml to allow compilation without Eclipse tasks
	cp ${FILESDIR}/build.xml ${S} || die "Unable to update build.xml"
	mkdir ${S}/src && mv ${S}/org ${S}/src || die "Unable to restructure SWT sources"
}

src_compile() {
	JAVA_HOME=$(java-config -O)

	# Identify the AWT path
	if [[ ${ARCH} == 'x86' ]] ; then
		export AWT_LIB_PATH=$JAVA_HOME/jre/lib/i386
	else
		export AWT_LIB_PATH=$JAVA_HOME/jre/lib/amd64
	fi

	# Identity the XTEST library location
	export XTEST_LIB_PATH=/usr/X11R6/lib

	# Fix the pointer size for AMD64
	[[ ${ARCH} == 'amd64' ]] && export SWT_PTR_CFLAGS=-DSWT_PTR_SIZE_64

	# Apply the Cairo patch
	use cairo && epatch ${FILESDIR}/cairo.patch

	# Fix the Makefile
	sed -e "s:-I\$(JAVA_HOME)/include\(.*\)$:-I\$(JAVA_HOME)/include -I\$(JAVA_HOME)/include/linux \1:" \
		-e "s:/usr/local:/usr:" \
		-e "s:CAIROCFLAGS = \([^ ]*\) \(.*\)$:CAIROCFLAGS = \1 -I/usr/include/cairo \2:" \
		make_linux.mak > Makefile

	einfo "Building AWT library"
	emake make_awt || die "Failed to build AWT support"

	einfo "Building SWT library"
	emake make_swt || die "Failed to build SWT support"

	if use accessibility ; then
		einfo "Building JAVA-AT-SPI bridge"
		emake make_atk || die "Failed to build ATK support"
	fi

	if use gnome ; then
		einfo "Building GNOME VFS support"
		emake make_gnome || die "Failed to build GNOME VFS support"
	fi

	if use mozilla ; then
		if use firefox ; then
			GECKO_SDK=/usr/lib/MozillaFirefox
		else
			GECKO_SDK=/usr/lib/mozilla
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
		emake make_mozilla || die "Failed to build Mozilla support"
	fi

	if use cairo ; then
		einfo "Building CAIRO support"
		emake make_cairo || die "Unable to build CAIRO support"
	fi

	einfo "Building JNI libraries"
	local libs="jar_swt-pi jar_swt"
	use cairo && libs="${libs} jar_cairo"
	use mozilla && libs="${libs} jar_mozilla"
	ant ${libs} || die "Failed to create JNI jars"
}

src_install() {
	java-pkg_dojar *.jar || die "Unable to install SWT Java interfaces"

	java-pkg_sointo /usr/lib
	java-pkg_doso *.so || die "Unable to install SWT libraries"

	dohtml about.html
}

pkg_postinst() {
	if use gnome ; then
		ewarn "Changes in the gnome-vfs API may cause warnings with SWT."
		ewarn "Please comment about the warnings at the following location:"
		ewarn "https://bugs.eclipse.org/bugs/show_bug.cgi?id=79268"

		ebeep 5
	fi
}
