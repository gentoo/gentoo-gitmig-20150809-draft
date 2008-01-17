# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase-data/kdebase-data-4.0.0.ebuild,v 1.1 2008/01/17 23:44:57 philantrop Exp $

EAPI="1"

RESTRICT="binchecks"

KMNAME=kdebase-runtime
KMNOMODULE=true
inherit kde4-meta

DESCRIPTION="Icons, localization data and various .desktop files from kdebase. Includes the l10n, pics and applnk subdirs."
IUSE=""
KEYWORDS="~amd64 ~x86"

DEPEND=">=kde-base/qimageblitz-0.0.4"
RDEPEND="${DEPEND}"

KMEXTRA="
	l10n/
	pics/"
# Note that the eclass doesn't do this for us, because of KMNOMODULE="true".
KMEXTRACTONLY="config-runtime.h.cmake"
