# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/qtjava/qtjava-3.4.3-r1.ebuild,v 1.1 2005/12/13 03:25:50 chriswhite Exp $

KMNAME=kdebindings
KM_MAKEFILESREV=1
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"

# Order is IMPORTANT!
inherit java-pkg kde-meta

DESCRIPTION="Java bindings for QT"
HOMEPAGE="http://developer.kde.org/language-bindings/java/qtjava.html"

KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""
DEPEND="virtual/jdk"
PATCHES="$FILESDIR/no-gtk-glib-check.diff"

src_compile() {
	myconf="$myconf --with-java=`java-config --jdk-home`"
	kde-meta_src_compile
}

# Doesn't really need kde, only qt? But then, it installs by default into $KDEDIR/...

src_install() {
	kde-meta_src_install

	# We dont want the installed location
	# Is there a cleaner way?
	rm -rf ${D}/usr/kde/3.4/lib/java

	# Proper install of jar
	java-pkg_dojar ${S}/qtjava/javalib/qtjava.jar
}
