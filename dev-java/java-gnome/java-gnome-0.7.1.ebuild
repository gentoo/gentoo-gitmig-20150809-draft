# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/java-gnome/java-gnome-0.7.1.ebuild,v 1.12 2003/05/03 19:51:59 tberman Exp $

IUSE="gnome"

S=${WORKDIR}/${P}
DESCRIPTION="Java bindings for GNOME and GTK libraries that allow GNOME and GTK applications to be written in Java"
SRC_URI="mirror://sourceforge/java-gnome/java-gnome-0.7.1.tar.gz"
HOMEPAGE="http://java-gnome.sourceforge.net/"
DEPEND="virtual/glibc
	gnome? ( >=gnome-base/gnome-libs-1.4 )
	virtual/jdk
	>=dev-java/jikes-1.0
	=dev-java/java-gtk-0.7.1"
RDEPEND="$DEPEND"
SLOT="0.7"
LICENSE="LGPL-2.1"
KEYWORDS="~x86 ~ppc ~sparc"

src_compile() {
	local myconf
	
	#JAVAC="`which jikes` -classpath $CLASSPATH:." \
		./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--with-java-prefix=$JAVA_HOME \
		$myconf || die "./configure failed"

	myclasspath=`java-config --full-classpath=java-gtk | sed "s/\:/\\\\\:/g"`

	cp src/Makefile src/Makefile.orig
	sed -e "s|CLASSPATH = tools\:.|CLASSPATH = ${myclasspath}\:tools\:.|" \
		< src/Makefile.orig > src/Makefile

	cp src/tools/Makefile src/tools/Makefile.orig
	sed -e "s|CLASSPATH = .|CLASSPATH = ${myclasspath}\:.|" \
		< src/tools/Makefile.orig > src/tools/Makefile
	
	cp test/Makefile test/Makefile.orig
	sed -e "s|CLASSPATH = ../lib/gtk.jar\:../lib/gnome.jar|CLASSPATH = ${myclasspath}\:.\:../lib/gtk.jar\:../lib/gnome.jar|" \
		< test/Makefile.orig > test/Makefile

	cp src/other/{Base*.java,GStringArray.java,GListString.java} src/gnu/gdk/

	make || die
}

src_install () {
	make prefix=${D}/usr install || die
	
	mv ${D}/usr/doc ${D}/usr/share/
	
	rm ${D}/usr/share/java-gtk/gtk.jar
	rm ${D}/usr/share/java-gtk/gnome.jar

	rm ${D}/usr/lib/libGTKJava.so*

	rm ${D}/usr/lib/libGNOMEJava.so
	dosym /usr/lib/libGNOMEJava.so.${PV} /usr/lib/libGNOMEJava.so

	rm ${D}/usr/share/java-gnome/gtk*.jar
		
	echo "/usr/share/java-gnome/gnome-${PV}.jar:" \
		> ${D}/usr/share/java-gnome/classpath.env
		
}
