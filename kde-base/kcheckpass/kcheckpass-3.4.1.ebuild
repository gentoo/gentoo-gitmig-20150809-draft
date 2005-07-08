# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcheckpass/kcheckpass-3.4.1.ebuild,v 1.7 2005/07/08 03:08:45 weeve Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE pam client that allows you to auth as a specified user without actually doing anything as that user"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE="pam"
DEPEND="pam? ( kde-base/kdebase-pam ) !pam? ( sys-apps/shadow )"

