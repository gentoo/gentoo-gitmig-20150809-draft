# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase-l10n/kdebase-l10n-3.4.0_rc1.ebuild,v 1.2 2005/03/02 00:55:33 cryos Exp $

KMNAME=kdebase
KMMODULE=l10n
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="l10n files from kdebase"
KEYWORDS="~x86 ~amd64"
IUSE=""

KMNODOCS=true
