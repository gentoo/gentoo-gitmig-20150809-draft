# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kuser/kuser-4.5.2.ebuild,v 1.1 2010/10/06 09:17:29 alexxy Exp $

EAPI="3"

KDE_HANDBOOK="optional"
KMNAME="kdeadmin"

inherit kde4-meta

DESCRIPTION="KDE application that helps you manage system users"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep kdepimlibs)
"
# notify is needed for dialogs
RDEPEND="${DEPEND}
	$(add_kdebase_dep knotify)
"
