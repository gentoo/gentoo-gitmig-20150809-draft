# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/smoke/smoke-3.3.1.ebuild,v 1.1 2004/11/06 17:23:33 danarmak Exp $

KMNAME=kdebindings
KMEXTRACTONLY="kalyptus/kalyptus kalyptus/*.pm"
inherit kde-meta

DESCRIPTION="Scripting Meta Object Kompiler Engine: a language-agnostic bindings generator for qt and kde"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lang/perl"
PATCHES="$FILESDIR/no-gtk-glib-check.diff $FILESDIR/parallel-make.diff"

