# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kjsembed/kjsembed-3.3.1.ebuild,v 1.6 2005/02/11 13:18:26 danarmak Exp $

KMNAME=kdebindings
KM_MAKEFILESREV=1
MAXKDEVER=3.3.2
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE javascript parser and embedder"
KEYWORDS="x86"
IUSE=""
#DEPEND="$(deprange $PV $MAXKDEVER  kde-base/kwin)"
DEPEND="$(deprange $PV $MAXKDEVER  kde-base/kdebase)"
OLDDEPEND="~kde-base/kwin-$PV"

PATCHES="$FILESDIR/no-gtk-glib-check.diff"

# Probably missing some deps, too
