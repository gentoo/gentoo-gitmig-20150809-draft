# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kjsembed/kjsembed-3.3.1.ebuild,v 1.1 2004/11/06 17:23:32 danarmak Exp $

KMNAME=kdebindings
inherit kde-meta

DESCRIPTION="KDE javascript parser and embedder"
KEYWORDS="~x86"
IUSE=""
#DEPEND="~kde-base/kwin-$PV"
DEPEND="~kde-base/kdebase-$PV"
PATCHES="$FILESDIR/no-gtk-glib-check.diff"

# Probably missing some deps, too
