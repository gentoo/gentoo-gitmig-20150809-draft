# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/keditbookmarks/keditbookmarks-4.8.1.ebuild,v 1.1 2012/03/06 23:35:20 dilfridge Exp $

EAPI=4

KMNAME="kde-baseapps"
VIRTUALX_REQUIRED=test
inherit kde4-meta

DESCRIPTION="KDE's bookmarks editor"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep libkonq)
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	lib/konq/
"
