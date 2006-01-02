# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdejava/kdejava-3.4.3-r1.ebuild,v 1.2 2006/01/02 17:55:32 hansmi Exp $

KMNAME=kdebindings
KMEXTRACTONLY=qtjava
KMCOPYLIB="libqtjavasupport qtjava/javalib/qtjava"
KM_MAKEFILESREV=1
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit java-pkg kde-meta

DESCRIPTION="KDE java bindings"
KEYWORDS="~amd64 ppc ~sparc x86"
IUSE=""
COMMONDEPEND="$(deprange-dual $PV $MAXKDEVER kde-base/kwin)
	$(deprange-dual $PV $MAXKDEVER kde-base/kcontrol)
	$(deprange $PV $MAXKDEVER kde-base/qtjava)"
DEPEND="virtual/jdk $COMMONDEPEND"
RDEPEND="virtual/jre $COMMONDEPEND"
OLDDEPEND="~kde-base/kwin-$PV ~kde-base/kcontrol-$PV ~kde-base/qtjava-$PV virtual/jdk"

PATCHES="$FILESDIR/no-gtk-glib-check.diff $FILESDIR/kdejava-3.4.0_rc1-classpath.diff"


# Probably missing other kdebase, kdepim etc deps
# Needs to be compiled with just kdelibs installed to make sure

# Someone who knows about java-in-gentoo should look at this and the
# other java kdebindings, and fix the stupid thing
src_unpack() {
	kde-meta_src_unpack

	# $PREFIX-dependant, so don't go into the makefile tarballs
	cd $S/kdejava/koala/org/kde/koala
	for x in Makefile.am Makefile.in; do
		sed -i -e "s:_CLASSPATH_:$(java-config -p qtjava-3.4):" $x
	done
}

src_compile() {
	myconf="$myconf --with-java=`java-config --jdk-home`"
	kde-meta_src_compile
}

src_install() {
	kde-meta_src_install
	rm -rf ${D}/usr/kde/3.4/lib/java
	java-pkg_dojar ${S}/kdejava/koala/koala.jar
}
