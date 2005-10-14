# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/secpolicy/secpolicy-3.5_beta1.ebuild,v 1.2 2005/10/14 18:42:02 danarmak Exp $
KMNAME=kdeadmin
MAXKDEVER=3.5.0_beta2
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE: Display PAM security policies"
KEYWORDS="~amd64"
IUSE=""
DEPEND=""

# NOTE TODO some dep is missing here - check on empty install