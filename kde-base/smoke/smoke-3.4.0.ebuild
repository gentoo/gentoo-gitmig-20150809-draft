# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/smoke/smoke-3.4.0.ebuild,v 1.2 2005/03/18 16:51:36 morfic Exp $

KMNAME=kdebindings
KMEXTRACTONLY="kalyptus/kalyptus kalyptus/*.pm"
KM_MAKEFILESREV=1
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="Scripting Meta Object Kompiler Engine: a language-agnostic bindings generator for qt and kde"
HOMEPAGE="http://developer.kde.org/language-bindings/smoke/"

KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND="dev-lang/perl"
PATCHES="$FILESDIR/no-gtk-glib-check.diff
$FILESDIR/parallel-make.diff"

# enable-final works, but requires at least 1.5GB of RAM to complete without swapping,
# so it's best to turn it off here. (I don't have that much RAM, so can't estimate
# how much would be enough, but it's at least that much... --danarmak)
src_compile() {
	kde-meta_src_compile myconf
	# override myconf's setting of enable-final
	myconf="$myconf --disable-final"
	kde-meta_src_compile configure make
}
