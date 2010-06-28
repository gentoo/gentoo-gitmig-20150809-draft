# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kuser/kuser-4.4.4.ebuild,v 1.4 2010/06/28 00:10:44 fauli Exp $

EAPI="3"

KMNAME="kdeadmin"

inherit kde4-meta

DESCRIPTION="KDE application that helps you manage system users"
KEYWORDS="~alpha amd64 ~ia64 ~ppc ~ppc64 ~sparc x86 ~amd64-linux ~x86-linux"
IUSE="debug +handbook"

DEPEND="
	$(add_kdebase_dep kdepimlibs)
"
# notify is needed for dialogs
RDEPEND="${DEPEND}
	$(add_kdebase_dep knotify)
"
