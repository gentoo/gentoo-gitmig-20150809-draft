# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/smoke/smoke-3.4.0_beta2.ebuild,v 1.1 2005/02/05 11:39:28 danarmak Exp $

KMNAME=kdebindings
KMEXTRACTONLY="kalyptus/kalyptus kalyptus/*.pm"
KM_MAKEFILESREV=1
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="Scripting Meta Object Kompiler Engine: a language-agnostic bindings generator for qt and kde"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lang/perl"
PATCHES="$FILESDIR/no-gtk-glib-check.diff"

