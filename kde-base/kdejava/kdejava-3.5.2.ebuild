# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdejava/kdejava-3.5.2.ebuild,v 1.7 2006/07/07 09:36:09 corsair Exp $

KMNAME=kdebindings
KMEXTRACTONLY=qtjava
KMCOPYLIB="libqtjavasupport qtjava/javalib/qtjava"
KM_MAKEFILESREV=1
MAXKDEVER=3.5.3
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE java bindings"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""
COMMONDEPEND="$(deprange-dual $PV 3.5.3 kde-base/kwin)
	$(deprange-dual $PV 3.5.3 kde-base/kcontrol)
	$(deprange $PV 3.5.3 kde-base/qtjava)"
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
		mv $x $x.orig
		sed -e "s:_CLASSPATH_:$(java-config -p qtjava):" $x.orig > $x
		rm $x.orig
	done
}

src_compile() {
	myconf="$myconf --with-java=`java-config --jdk-home`"
	kde-meta_src_compile
}
