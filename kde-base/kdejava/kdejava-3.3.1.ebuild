# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdejava/kdejava-3.3.1.ebuild,v 1.10 2005/02/19 15:32:00 danarmak Exp $

KMNAME=kdebindings
KMEXTRACTONLY=qtjava
KMCOPYLIB="libqtjavasupport qtjava/javalib/qtjava"
KM_MAKEFILESREV=1
MAXKDEVER=3.3.2
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE java bindings"
KEYWORDS="x86"
IUSE=""
#COMMONDEPEND="$(deprange $PV $MAXKDEVER kde-base/kwin)
#	$(deprange $PV $MAXKDEVER kde-base/kcontrol)
#	$(deprange $PV $MAXKDEVER kde-base/qtjava)"
COMMONDEPEND="$(deprange $PV $MAXKDEVER kde-base/kdebase)
	$(deprange $PV $MAXKDEVER kde-base/qtjava)"
DEPEND="virtual/jdk $COMMONDEPEND"
RDEPEND="virtual/jre $COMMONDEPEND"
OLDDEPEND="~kde-base/kwin-$PV ~kde-base/kcontrol-$PV ~kde-base/qtjava-$PV virtual/jdk"

PATCHES="$FILESDIR/no-gtk-glib-check.diff $FILESDIR/$P-classpath.diff"


# Probably missing other kdebase, kdepim etc deps
# Needs to be compiled with just kdelibs installed to make sure

# Someone who knows about java-in-gentoo should look at this and the
# other java kdebindings, and fix the stupid thing
src_unpack() {
	kde-meta_src_unpack

	# $PREFIX-dependant, so don't go into the makefile tarballs
	cd $S/kdejava/koala/org/kde/koala
	for x in Makefile.am Makefile.in; do
		mv $x $x.orig
		sed -e "s:_CLASSPATH_:$(java-config -p qtjava):" $x.orig > $x
		rm $x.orig
	done
}

src_compile() {
	myconf="$myconf --with-java=`java-config --jdk-home`"
	kde-meta_src_compile
}
