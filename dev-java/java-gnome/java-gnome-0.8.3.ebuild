# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/java-gnome/java-gnome-0.8.3.ebuild,v 1.3 2004/03/18 06:53:40 zx Exp $

inherit eutils

DESCRIPTION="Java bindings for GNOME and GTK libraries that allow GNOME and GTK applications to be written in Java"
SRC_URI="mirror://sourceforge/java-gnome/${P}.tar.bz2"
HOMEPAGE="http://java-gnome.sourceforge.net/"
DEPEND="virtual/glibc
		>=gnome-base/libgnome-2.0
		>=gnome-base/libgnomecanvas-2.0
		>=gnome-base/libglade-2.0
		virtual/jdk
		>=app-text/docbook-sgml-utils-0.6.12"

SLOT="0.8"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ~sparc"
IUSE=""

S=${WORKDIR}/${P}

src_compile() {
	epatch ${FILESDIR}/java-gnome-${PV}-gentoo.diff

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--with-java-prefix=${JAVA_HOME} || die "./configure failed"

	make || die
}

src_install() {
	make prefix=${D}/usr install || die

	dodir /usr/share/java-gnome/lib
	mv ${D}/usr/share/java-gnome/*.jar ${D}/usr/share/java-gnome/lib/

	dosym /usr/share/java-gnome/lib/gnome${SLOT}-${PV}.jar /usr/share/java-gnome/lib/gnome${SLOT}.jar

	dosym /usr/lib/libgnomejava${SLOT}.so.${PV} /usr/lib/libgnomejava${SLOT}.so

	echo "DESCRIPTION=${DESCRIPTION}" \
		> ${D}/usr/share/java-gnome/package.env

	echo "CLASSPATH=/usr/share/java-gnome/lib/gtk${SLOT}.jar:/usr/share/java-gnome/lib/gnome${SLOT}.jar:/usr/share/java-gnome/lib/glade${SLOT}.jar:/usr/share/java-gnome/lib/gconf${SLOT}.jar:/usr/share/java-gnome/lib/gnomevte${SLOT}.jar:/usr/share/java-gnome/lib/gtkhtml${SLOT}.jar" \
		>> ${D}/usr/share/java-gnome/package.env
}
