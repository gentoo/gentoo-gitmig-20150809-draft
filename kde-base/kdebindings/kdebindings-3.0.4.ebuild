# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebindings/kdebindings-3.0.4.ebuild,v 1.8 2003/03/11 21:11:45 seemant Exp $
# TODO: add gnustep bindings
inherit kde-dist

IUSE="mozilla python java"
DESCRIPTION="KDE $PV - kde library bindings for languages other than c++"
KEYWORDS="x86 ppc alpha"

newdepend ">=kde-base/kdebase-${PV}
	=x11-libs/gtk+-1.2*
	dev-lang/perl
	python? ( dev-lang/python )
	java? (	virtual/jdk )
	=x11-libs/gtk+-1.2*
	=dev-libs/glib-1.2*
	>=kde-base/kdenetwork-${PV}
	mozilla? ( net-www/mozilla )"

use python									|| myconf="$myconf --without-python"
use java	&& myconf="$myconf --with-java=$(java-config --jdk-home)"	|| myconf="$myconf --without-java"
#myconf="$myconf --enable-objc"

export LIBPYTHON="`python-config`"

src_unpack()
{
	kde_src_unpack

	if [ -z "`use mozilla`" ]; then
	# disable mozilla bindings/xpart
	cd ${S}
	cp configure configure.orig
	sed -e 's:mozilla_incldirs=:# mozilla_incldirs=:' configure.orig > configure
	chmod +x configure
	fi
}
