# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/swt/swt-3.1_pre2.ebuild,v 1.1 2005/04/09 12:19:51 karltk Exp $

inherit eutils java-pkg

DESCRIPTION="SWT Library"
HOMEPAGE="http://www.eclipse.org/"
SRC_URI="http://download.eclipse.org/downloads/drops/S-3.1M2-200409240800/swt-3.1M2-linux-gtk.zip"
LICENSE="CPL-1.0 LGPL-2.1 MPL-1.1"
KEYWORDS="~x86 ~amd64"
SLOT="3"

IUSE="gnome mozilla"

RDEPEND=">=x11-libs/gtk+-2.2.4
	mozilla? ( >=www-client/mozilla-1.5 )
	gnome? ( =gnome-base/gnome-vfs-2* =gnome-base/libgnomeui-2* )"

DEPEND="${RDEPEND}
	>=virtual/jdk-1.4
	dev-java/ant
	app-arch/unzip"

src_unpack() {
	mkdir ${S} && cd ${S}
	unpack ${A}

	rm -f *.so *.jar
	use mozilla || rm -f swt-mozillasrc.zip

	for i in *.zip ; do
		einfo "Unpacking ${i} to ${S}"
		unzip ${i} &> /dev/null
	done

	if use mozilla; then
		cp library/*.cpp ${S} || die "Failed copy *.cpp"
	fi

	mkdir src && mv org src/
	cp ${FILESDIR}/build-${PV}.xml ${S}/build.xml || die "Failed to copy build.xml"

	sed 's/<javac /<javac target="1.2" source="1.3" /' -i ${S}/build.xml

	use mozilla ||
		(
			rm -rf ${S}/src/org/eclipse/swt/browser
			rm -rf ${S}/src/org/eclipse/swt/internal/mozilla
		)

}

src_compile() {
	if use gnome ; then
	    gnome_libs=`pkg-config --libs gnome-vfs-module-2.0 libgnome-2.0 libgnomeui-2.0 | sed -e "s:-pthread:-lpthread:" -e "s:-Wl,--export-dynamic:--export-dynamic:"`
	fi

	gtk_libs=`pkg-config --libs gtk+-2.0 | sed -e "s:-Wl,--export-dynamic:--export-dynamic:"`
	gtk_lib=`pkg-config --libs gtk+-2.0 gthread-2.0 | sed -e "s:-pthread:-lpthread:" -e "s:-Wl,--export-dynamic:--export-dynamic:"`
	atk_lib=`pkg-config --libs atk gtk+-2.0 | sed -e "s:-Wl,--export-dynamic:--export-dynamic:"`

	sed -e :a -e '/\\$/N; s/\\\n//; ta' make_linux.mak > makefile.mak
	moz_cflags="-O -fno-rtti -fno-exceptions -fPIC -Wall -Wno-non-virtual-dtor -DNO_nsEmbedString_1Equals \
		-DXPCOM_GLUE=1 -DMOZILLA_STRICT_API=1 -DSWT_VERSION=\$(SWT_VERSION) \$(NATIVE_STATS) \
		-include \$(MOZILLA_FIVE_HOME)/include/mozilla-config.h \
		-I./ -I./library \
		-I\$(MOZILLA_FIVE_HOME)/include \
		-I\$(MOZILLA_FIVE_HOME)/include/java \
		-I\$(MOZILLA_FIVE_HOME)/include/nspr -I\$(MOZILLA_FIVE_HOME)/include/nspr/include \
		-I\$(MOZILLA_FIVE_HOME)/include/xpcom -I\$(MOZILLA_FIVE_HOME)/include/xpcom/include \
		-I\$(MOZILLA_FIVE_HOME)/include/string -I\$(MOZILLA_FIVE_HOME)/include/string/include \
		-I\$(MOZILLA_FIVE_HOME)/include/embed_base -I\$(MOZILLA_FIVE_HOME)/include/embed_base/include \
		-I\$(MOZILLA_FIVE_HOME)/include/embedstring -I\$(MOZILLA_FIVE_HOME)/include/embedstring/include"
	moz_libs="-shared -Wl,--version-script=mozilla_exports -Bsymbolic -L\$(MOZILLA_FIVE_HOME) -lgtkembedmoz"

	sed -e "s:\`pkg-config --libs gtk+-2.0\`:${gtk_libs}:" \
		-e "s:\`pkg-config --libs atk gtk+-2.0\`:${atk_lib}:" \
		-e "s:\`pkg-config --libs gnome-vfs-module-2.0 libgnome-2.0 libgnomeui-2.0\`:${gnome_libs}:" \
		-e "s:-I\$(JAVA_HOME)/include:-I\$(JAVA_HOME)/include -I\$(JAVA_HOME)/include/linux:" \
		-e "s:-I\$(JAVA_HOME)/include\t:-I\$(JAVA_HOME)/include -I\$(JAVA_HOME)/include/linux:" \
		-e "s:MOZILLACFLAGS = .*$:MOZILLACFLAGS = ${moz_cflags}:" \
		-e "s:MOZILLALIBS = .*$:MOZILLALIBS = ${moz_libs}:" \
		makefile.mak > Makefile

	export XTEST_LIB_PATH=/usr/X11R6/lib
	export AWT_LIB_PATH=$JAVA_HOME/jre/bin

	make make_swt || die "Failed to build platform-independent SWT support"
	make make_atk || die "Failed to build atk support"

	if use gnome ; then
		einfo "Building GNOME VFS support"
		make make_gnome || die "Failed to build GNOME VFS support"
	fi

	if use mozilla ; then
		einfo "Building Mozilla component"
		make make_mozilla || die "Failed to build Mozilla support"
	fi

	einfo "Building java source"
	ant jar || die "Failed to create jar"
}

src_install() {
	java-pkg_dojar swt.jar || die "Installation of swt.jar failed"

	java-pkg_sointo /usr/lib
	java-pkg_doso *.so || die "Install of .so-files failed"

	dohtml about.html
}

