# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kfind/kfind-4.6.2.ebuild,v 1.4 2011/06/01 18:22:58 ranger Exp $
EAPI=3

KDE_HANDBOOK="optional"
KMNAME="kdebase-apps"
inherit kde4-meta

DESCRIPTION="KDE file finder utility"
KEYWORDS="amd64 ~arm ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep libkonq)
"
RDEPEND="${DEPEND}"
