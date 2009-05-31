# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/secpolicy/secpolicy-3.5.10.ebuild,v 1.2 2009/05/31 20:08:36 nixnut Exp $
KMNAME=kdeadmin
EAPI="1"
inherit kde-meta

DESCRIPTION="KDE: Display PAM security policies"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"
DEPEND=""

# NOTE TODO some dep is missing here - check on empty install
