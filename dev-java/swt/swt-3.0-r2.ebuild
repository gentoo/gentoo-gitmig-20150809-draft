# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/swt/swt-3.0-r2.ebuild,v 1.3 2005/03/23 16:16:06 seemant Exp $

inherit eutils java-pkg

IUSE="gnome mozilla"
DESCRIPTION="SWT library"
HOMEPAGE="http://www.eclipse.org/"
SRC_URI="http://download.eclipse.org/downloads/drops/R-3.0-200406251208/swt-3.0-linux-gtk.zip"
LICENSE="CPL-1.0 LGPL-2.1 MPL-1.1"
SLOT="3"
KEYWORDS="~x86 ~ppc ~amd64"

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

	# remove some files
	rm -f *.so *.jar
	use mozilla || rm -f swt-mozillasrc.zip

	for i in *.zip
	do
		einfo "Unpacking ${i} to ${S}"
		unzip ${i} &> /dev/null
	done
	use mozilla && mv library/xpcom.cpp ${S}

	mkdir src && mv org src/
	cp ${FILESDIR}/build-${PV}.xml ${S}/build.xml

	sed 's/<javac /<javac target="1.2" source="1.3" /' -i ${S}/build.xml

	use mozilla ||
		(
		rm -rf ${S}/src/org/eclipse/swt/browser
		rm -rf ${S}/src/org/eclipse/swt/internal/mozilla
		)
}

src_compile() {
	if use gnome ; then
	    gnome_libs=`pkg-config --libs gnome-vfs-module-2.0 libgnome-2.0 libgnomeui-2.0 | sed -e "s:-pthread:-lpthread:" -e "s:-Wl,--export:--export:"`
	fi

	gtk_lib=`pkg-config --libs gtk+-2.0 gthread-2.0 | sed -e "s:-pthread:-lpthread:" -e "s:-Wl,--export:--export:"`
	atk_lib=`pkg-config --libs atk gtk+-2.0 | sed -e "s:-Wl,--export:--export:"`

	sed -e "s:/bluebird/teamswt/swt-builddir/IBMJava2-141:$JAVA_HOME:" \
		-e "s:/bluebird/teamswt/swt-builddir/jdk1.5.0:$JAVA_HOME:" \
		-e "s:/mozilla/mozilla/1.6/linux_gtk2/mozilla/dist:$MOZILLA_FIVE_HOME:" \
		-e "s:/usr/lib/mozilla-1.6:$MOZILLA_FIVE_HOME:" \
		-e "s:\`pkg-config --libs gtk+-2.0 gthread-2.0\`:${gtk_lib}:" \
		-e "s:\`pkg-config --libs atk gtk+-2.0\`:${atk_lib}:" \
		-e "s:\`pkg-config --libs gnome-vfs-module-2.0 libgnome-2.0 libgnomeui-2.0\`:${gnome_lib}:" \
		-e "s:-I\$(JAVA_HOME)/include:-I\$(JAVA_HOME)/include -I\$(JAVA_HOME)/include/linux:" \
		-e "s:-I\$(JAVA_HOME)\t:-I\$(JAVA_HOME)/include -I\$(JAVA_HOME)/include/linux:" \
		-e "s:-L\$(MOZILLA_HOME)/lib -lembed_base_s:-L\$(MOZILLA_HOME) -lgtkembedmoz:" \
		-e "s:MOZILLACFLAGS = -O:MOZILLACFLAGS = -O -fPIC:" \
		-e "s:\$(JAVA_HOME)/jre/bin:\$(JAVA_HOME)/jre/lib/i386:" \
		make_gtk.mak > Makefile

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
	ant jar
}

src_install() {
	java-pkg_dojar swt.jar || die "Installation of swt.jar failed"

	exeinto /usr/lib
	doexe *.so ${D}/usr/lib || die "Install of .so-files failed"

	dohtml about.html
}
