# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebindings/kdebindings-2.2.2.ebuild,v 1.11 2002/08/14 13:08:53 murphy Exp $
inherit kde-dist

DESCRIPTION="KDE $PV - kde library bindings for languages other than c++"

KEYWORDS="x86 sparc sparc64"

newdepend ">=kde-base/kdebase-${PV}
	=x11-libs/gtk+-1.2*
	sys-devel/perl
	python? ( dev-lang/python )
	java? (	virtual/jdk )
	=x11-libs/gtk+-1.2*
	=dev-libs/glib-1.2*
	>=kde-base/kdenetwork-${PV}"

src_compile() {

	kde_src_compile myconf

	use python							|| myconf="$myconf --without-python"
	use java	&& myconf="$myconf --with-java=${JAVA_HOME}"	|| myconf="$myconf --without-java"
	
	kde_src_compile configure
    
	# the library_path is a kludge for a strange bug
	LIBRARY_PATH=${QTDIR}/lib LIBPYTHON=\"`python-config`\" make || die
	
}

