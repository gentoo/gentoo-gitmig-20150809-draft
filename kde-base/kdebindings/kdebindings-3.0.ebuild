# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebindings/kdebindings-3.0.ebuild,v 1.5 2002/05/21 18:14:10 danarmak Exp $

inherit kde-dist

DESCRIPTION="${DESCRIPTION}Bindings"

newdepend ">=kde-base/kdebase-${PV}
	>=x11-libs/gtk+-1.2.10-r4
	sys-devel/perl
	python? ( dev-lang/python )
	java? (	virtual/jdk )
	>=x11-libs/gtk+-1.2.6
	=dev-libs/glib-1.2*
	~kde-base/kdenetwork-${PV}"

src_compile() {

	kde_src_compile myconf

	use python							|| myconf="$myconf --without-python"
	#use java	&& myconf="$myconf --with-java=$(java-config --jdk-home)"	||
	myconf="$myconf --without-java"
	
	export LIBPYTHON="`python-config`"
	
	kde_src_compile configure
    
	# the library_path is a kludge for a strange bug
	LIBRARY_PATH=${QTDIR}/lib make || die
	
}

