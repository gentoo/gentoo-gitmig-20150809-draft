# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/dcopjava/dcopjava-3.4.0.ebuild,v 1.2 2005/03/18 17:12:04 morfic Exp $

# NOTE TODO install a jar file rather than a tree of class files, and use java-pkg.eclass,
# in keeping with policy

KMNAME=kdebindings
KMEXTRACTONLY="kdejava/configure.in.in"
KM_MAKEFILESREV=1
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="Java bindings for DCOP"
KEYWORDS="~x86 ~ppc" # broken according to upstream - 3.4a1 README
IUSE=""
DEPEND="virtual/jdk"
RDEPEND="virtual/jre"
PATCHES="$FILESDIR/no-gtk-glib-check.diff"


pkg_setup() {
	ewarn "This package is consdered broken by upstream. You're on your own."
}

src_compile () {
	myconf="$myconf --with-java=`java-config --jdk-home`"
	kde-meta_src_compile
}