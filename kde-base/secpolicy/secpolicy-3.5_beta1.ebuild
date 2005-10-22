# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/secpolicy/secpolicy-3.5_beta1.ebuild,v 1.3 2005/10/22 07:50:53 halcy0n Exp $
KMNAME=kdeadmin
MAXKDEVER=3.5.0_beta2
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE: Display PAM security policies"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND=""

# NOTE TODO some dep is missing here - check on empty install