# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kalyptus/kalyptus-3.3.1.ebuild,v 1.1 2004/11/06 17:23:32 danarmak Exp $

KMNAME=kdebindings
inherit kde-meta

DESCRIPTION="KDE bindings generator for C, ObjC and Java"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lang/perl"
PATCHES="$FILESDIR/no-gtk-glib-check.diff"

# Weird build system, weirder errors.
# You're welcome to fix this in a better way --danarmak
src_compile () {
    export S=$S/kalyptus
    kde-meta_src_compile
}

src_install() {
    cd $S/kalyptus
    make install DESTDIR=$D
}