# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebindings/kdebindings-3.2.3.ebuild,v 1.4 2004/07/22 05:17:34 lv Exp $
# TODO: add gnustep, objc bindings

inherit kde-dist flag-o-matic

DESCRIPTION="KDE library bindings for languages other than c++"

KEYWORDS="~x86 ~ppc amd64 ~sparc"
IUSE="mozilla java python ruby gtk"

DEPEND="=kde-base/kdebase-${PV}
	~kde-base/kdenetwork-${PV}
	gtk? ( =x11-libs/gtk+-1.2* )
	=dev-libs/glib-1.2*
	python? ( dev-lang/python )
	java? (	virtual/jdk )
	ruby? ( virtual/ruby )
	mozilla? ( net-www/mozilla )"

src_unpack() {
	kde_src_unpack

	if ! use mozilla ; then
	# disable mozilla bindings/xpart, because configure doesn't seem to do so
	# even when it doesn't detect the mozilla headers
	cd ${S}/xparts
	cp Makefile.am Makefile.am.orig
	sed -e 's:mozilla::' Makefile.am.orig > Makefile.am
	fi

	cd ${S} && aclocal
}

src_compile() {
	use python	|| myconf="$myconf --without-python"
	use java	&& myconf="$myconf --with-java=`java-config --jdk-home`"	|| myconf="$myconf --without-java"
	use ruby	|| myconf="$myconf --without-ruby"

	# obj bindings are officially broken
	#myconf="$myconf --enable-objc"

	# we need to have csant (from pnet, from portable.NET) in portage for qtsharp
	export DO_NOT_COMPILE="$DO_NOT_COMPILE qtsharp"

	export LIBPYTHON="`python-config`"

	# fix bug #14756 fex. Doesn't compile well with -j2.
	export MAKEOPTS="$MAKEOPTS -j1"

	use hppa && append-flags -ffunction-sections

	kde_src_compile
}
