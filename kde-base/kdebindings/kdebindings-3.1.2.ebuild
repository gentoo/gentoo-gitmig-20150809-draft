# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebindings/kdebindings-3.1.2.ebuild,v 1.1 2003/05/07 11:05:48 danarmak Exp $
# TODO: add gnustep, objc bindings
inherit kde-dist 

IUSE="mozilla java python"
DESCRIPTION="KDE library bindings for languages other than c++"
KEYWORDS="x86 ~sparc ~alpha"

newdepend "=kde-base/kdebase-${PV}*
	=x11-libs/gtk+-1.2*
	dev-lang/perl
	python? ( dev-lang/python )
	java? (	virtual/jdk )
	=dev-libs/glib-1.2*
	~kde-base/kdenetwork-${PV}
	mozilla? ( net-www/mozilla )"

use python									|| myconf="$myconf --without-python"
use java	&& myconf="$myconf --with-java=$(java-config --jdk-home)"	|| myconf="$myconf --without-java"

# obj bindings are officially broken
#myconf="$myconf --enable-objc"

# we need to have csant (from pnet, from portable.NET) in portage for qtsharp
export DO_NOT_COMPILE="$DO_NOT_COMPILE qtsharp"

export LIBPYTHON="`python-config`"

# fix bug #14756 fex. Doesn't compile well with -j2.
export MAKEOPTS="$MAKEOPTS -j1"

src_unpack()
{
	kde_src_unpack

	if [ -z "`use mozilla`" ]; then
	# disable mozilla bindings/xpart, because configure doesn't seem to do so
	# even when it doesn't detect the mozilla headers
	cd ${S}/xparts
	cp Makefile.am Makefile.am.orig
	sed -e 's:mozilla::' Makefile.am.orig > Makefile.am
	fi
}

