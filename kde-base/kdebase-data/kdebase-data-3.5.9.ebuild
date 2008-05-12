# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase-data/kdebase-data-3.5.9.ebuild,v 1.5 2008/05/12 20:02:33 ranger Exp $

ARTS_REQUIRED="never"
RESTRICT="binchecks strip"

KMNAME=kdebase
KMNOMODULE=true
EAPI="1"
inherit kde-meta

DESCRIPTION="Icons, localization data and .desktop files from kdebase. Includes l10n, pics and applnk subdirs."
KEYWORDS="alpha ~amd64 hppa ia64 ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="
!kde-base/kdebase-l10n !kde-base/kdebase-applnk !kde-base/kdebase-pics" # replaced these three ebuilds

KMEXTRA="l10n pics applnk"
