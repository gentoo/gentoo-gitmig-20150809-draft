# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kjsembed/kjsembed-3.5.0_rc1.ebuild,v 1.1 2005/11/12 15:49:29 danarmak Exp $

KMNAME=kdebindings
KM_MAKEFILESREV=1
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE javascript parser and embedder"
HOMEPAGE="http://xmelegance.org/kjsembed/"

KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="$(deprange-dual $PV $MAXKDEVER kde-base/kwin)"
OLDDEPEND="~kde-base/kwin-$PV"

PATCHES="$FILESDIR/no-gtk-glib-check.diff"

# Probably missing some deps, too
