# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebindings/kdebindings-2.2.1-r1.ebuild,v 1.2 2001/10/01 11:04:22 danarmak Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-dist || die

DESCRIPTION="${DESCRIPTION}Bindings"

NEWDEPEND=">=kde-base/kdebase-${PV}
	>=x11-libs/gtk+-1.2.10
	sys-devel/perl
	python? ( dev-lang/python )
	java? (	dev-lang/jdk )"

DEPEND="$DEPEND $NEWDEPEND"
RDEPEND="$RDEPEND $NEWDEPEND"

src_compile() {

	kde_src_compile myconf

	use python							|| myconf="$myconf --without-python"
	use java	&& myconf="$myconf --with-java=/opt/java"	|| myconf="$myconf --without-java"

	kde_src_compile configure

	LIBPYTHON=\"`python-config`\" make || die
	
}

