# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/dcopperl/dcopperl-3.3.1.ebuild,v 1.3 2004/12/25 15:47:42 danarmak Exp $

KMNAME=kdebindings
KM_MAKEFILESREV=1
MAXKDEVER=3.3.2
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="Perl bindings for DCOP"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lang/perl"
PATCHES="$FILESDIR/no-gtk-glib-check.diff"
