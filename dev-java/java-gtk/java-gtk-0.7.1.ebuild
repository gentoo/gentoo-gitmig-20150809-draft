# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-java/java-gtk/java-gtk-0.7.1.ebuild,v 1.7 2002/09/20 20:54:07 vapier Exp $

S=${WORKDIR}/java-gnome-${PV}
DESCRIPTION="GTK+ bindings for Java"
SRC_URI="mirror://sourceforge/java-gnome/java-gnome-0.7.1.tar.gz"
HOMEPAGE="http://java-gnome.sourceforge.net/"
DEPEND="virtual/glibc
	virtual/jdk
	=x11-libs/gtk+-1.2*
	>=dev-java/jikes-1.0"
RDEPEND="$DEPEND"
SLOT="0.7"
LICENSE="LGPL-2.1"
KEYWORDS="x86"

src_compile() {
	local myconf

	myconf="--with-gtk-only"
		
	JAVAC="`which jikes` -classpath $CLASSPATH:." \
		./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--with-java-prefix=$JAVA_HOME \
		$myconf || die "./configure failed"

	cp src/Makefile src/Makefile.orig
	sed -e "s:CLASSPATH = tools\:.:CLASSPATH = ${CLASSPATH}\:tools\:.:" \
		< src/Makefile.orig > src/Makefile

	cp src/tools/Makefile src/tools/Makefile.orig
	sed -e "s:CLASSPATH = .:CLASSPATH = ${CLASSPATH}\:.:" \
		< src/tools/Makefile.orig > src/tools/Makefile
	
	cp test/Makefile test/Makefile.orig
	sed -e "s:CLASSPATH = ../lib/gtk.jar\:../lib/gnome.jar:CLASSPATH = ${CLASSPATH}\:.\:../lib/gtk.jar\:../lib/gnome.jar:" \
		< test/Makefile.orig > test/Makefile
	
	emake || die
}

src_install () {
	make prefix=${D}/usr install || die
	
	mv ${D}/usr/doc ${D}/usr/share/
	
	rm ${D}/usr/share/java-gtk/gtk.jar

	rm ${D}/usr/lib/libGTKJava.so
	dosym /usr/lib/libGTKJava.so.${PV} /usr/lib/libGTKJava.so
		
	echo "/usr/share/java-gtk/gtk-${PV}.jar:" \
		> ${D}/usr/share/java-gtk/classpath.env
		
}
