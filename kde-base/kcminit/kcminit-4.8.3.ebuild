# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcminit/kcminit-4.8.3.ebuild,v 1.4 2012/05/24 08:23:52 ago Exp $

EAPI=4

KMNAME="kde-workspace"
inherit kde4-meta

DESCRIPTION="KCMInit - runs startups initialization for Control Modules."
KEYWORDS="amd64 ~arm ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep ksplash)
"
RDEPEND="${DEPEND}"
