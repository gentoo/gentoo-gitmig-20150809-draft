# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcheckpass/kcheckpass-3.4.0_beta1.ebuild,v 1.1 2005/01/15 02:24:28 danarmak Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE pam client that allows you to auth as a specified user without actually doing anything as that user"
KEYWORDS="~x86"
IUSE="pam"
DEPEND="pam? ( sys-libs/pam $(deprange-dual $PV $MAXKDEVER kde-base/kdebase-pam) ) !pam? ( sys-apps/shadow )"

