# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/smoke/smoke-3.3.1.ebuild,v 1.7 2005/02/19 17:01:34 danarmak Exp $

KMNAME=kdebindings
KMEXTRACTONLY="kalyptus/kalyptus kalyptus/*.pm"
KM_MAKEFILESREV=1
MAXKDEVER=3.3.2
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="Scripting Meta Object Kompiler Engine: a language-agnostic bindings generator for qt and kde"
HOMEPAGE="http://developer.kde.org/language-bindings/smoke/"

KEYWORDS="x86"
IUSE=""
DEPEND="dev-lang/perl"
PATCHES="$FILESDIR/no-gtk-glib-check.diff $FILESDIR/parallel-make.diff"

# enable-final works, but requires at least 1.5GB of RAM to complete without swapping,
# so it's best to turn it off here. (I don't have that much RAM, so can't estimate
# how much would be enough, but it's at least that much... --danarmak)
src_compile() {
	kde-meta_src_compile myconf
	# override myconf's setting of enable-final
	myconf="$myconf --disable-final"
	kde-meta_src_compile configure make
}
