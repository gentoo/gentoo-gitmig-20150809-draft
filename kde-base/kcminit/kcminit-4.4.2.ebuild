# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcminit/kcminit-4.4.2.ebuild,v 1.1 2010/03/30 19:37:32 spatz Exp $

EAPI="3"

KMNAME="kdebase-workspace"
inherit kde4-meta

DESCRIPTION="KCMInit - runs startups initialization for Control Modules."
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep ksplash)
"
RDEPEND="${DEPEND}"
