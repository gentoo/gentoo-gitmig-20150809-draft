# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebindings/kdebindings-2.2.2.ebuild,v 1.5 2002/04/12 19:07:06 spider Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-dist || die

DESCRIPTION="${DESCRIPTION}Bindings"

newdepend ">=kde-base/kdebase-${PV}
	>=x11-libs/gtk+-1.2.10-r4
	sys-devel/perl
	python? ( dev-lang/python )
	java? (	virtual/jdk )
	>=x11-libs/gtk+-1.2.6
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

