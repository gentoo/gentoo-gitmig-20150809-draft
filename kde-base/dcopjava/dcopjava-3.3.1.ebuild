# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/dcopjava/dcopjava-3.3.1.ebuild,v 1.2 2004/11/07 03:01:03 mr_bones_ Exp $

# NOTE TODO install a jar file rather than a tree of class files, and use java-pkg.eclass,
# in keeping with policy

KMNAME=kdebindings
KMEXTRACTONLY="kdejava/configure.in.in"
inherit kde-meta

DESCRIPTION="Java bindings for DCOP"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/jdk"
RDEPEND="virtual/jre"
PATCHES="$FILESDIR/no-gtk-glib-check.diff"

myconf="$myconf --with-java=`java-config --jdk-home`"

pkg_setup() {
	ewarn "This package is consdered broken by upstream. You're on your own."
}
