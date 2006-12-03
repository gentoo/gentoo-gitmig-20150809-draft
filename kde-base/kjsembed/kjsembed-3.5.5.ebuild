# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kjsembed/kjsembed-3.5.5.ebuild,v 1.6 2006/12/03 19:22:07 corsair Exp $

KMNAME=kdebindings
KM_MAKEFILESREV=1
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE javascript parser and embedder"
HOMEPAGE="http://xmelegance.org/kjsembed/"

KEYWORDS="~alpha amd64 ppc ppc64 sparc x86"
IUSE=""
DEPEND="$(deprange-dual $PV $MAXKDEVER kde-base/kwin)"
OLDDEPEND="~kde-base/kwin-$PV"

RDEPEND="${DEPEND}"

PATCHES="$FILESDIR/no-gtk-glib-check.diff"

# Probably missing some deps, too
