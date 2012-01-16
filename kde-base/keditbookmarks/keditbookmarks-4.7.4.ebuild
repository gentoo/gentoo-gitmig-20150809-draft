# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/keditbookmarks/keditbookmarks-4.7.4.ebuild,v 1.3 2012/01/16 22:33:25 ago Exp $

EAPI=4

KMNAME="kde-baseapps"
inherit kde4-meta

DESCRIPTION="KDE's bookmarks editor"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep libkonq)
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	lib/konq/
"

RESTRICT="test"
# bug 392703
