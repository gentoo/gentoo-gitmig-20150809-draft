# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase-l10n/kdebase-l10n-3.4.0_beta1.ebuild,v 1.1 2005/01/15 02:24:30 danarmak Exp $

KMNAME=kdebase
KMMODULE=l10n
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="l10n files from kdebase"
KEYWORDS="~x86"
IUSE=""

KMNODOCS=true
