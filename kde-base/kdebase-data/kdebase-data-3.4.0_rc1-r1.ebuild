# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase-data/kdebase-data-3.4.0_rc1-r1.ebuild,v 1.4 2005/03/24 22:48:16 motaboy Exp $

KMNAME=kdebase
KMNOMODULE=true
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="Icons, localization data and various .desktop files from kdebase. Includes the l10n, pics and applnk subdirs."
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="
!kde-base/kdebase-l10n !kde-base/kdebase-applnk !kde-base/kdebase-pics" # replaced these three ebuilds

KMEXTRA="l10n pics applnk"

