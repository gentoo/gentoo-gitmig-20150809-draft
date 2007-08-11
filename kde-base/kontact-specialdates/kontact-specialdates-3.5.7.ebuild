# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kontact-specialdates/kontact-specialdates-3.5.7.ebuild,v 1.7 2007/08/11 15:27:40 armin76 Exp $

KMNAME=kdepim
KMNOMODULE=true
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="Special Dates plugin for Kontact: displays a summary of important holidays and calendar events"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="$(deprange $PV $MAXKDEVER kde-base/libkdepim)
	$(deprange $PV $MAXKDEVER kde-base/kontact)
	$(deprange $PV $MAXKDEVER kde-base/kaddressbook)
	$(deprange $PV $MAXKDEVER kde-base/korganizer)
	$(deprange $PV $MAXKDEVER kde-base/libkholidays)"
RDEPEND="${DEPEND}
	>=kde-base/libkdepim-3.5.6-r1" # Force this version temporarily, #136810.

KMCOPYLIB="libkdepim libkdepim/
	libkpinterfaces kontact/interfaces
	libkaddressbook kaddressbook
	libkorganizer_calendar korganizer
	libkholidays libkholidays"
KMEXTRACTONLY="libkholidays
	kontact/interfaces/
	kaddressbook
	korganizer
	libkdepim"
KMEXTRA="kontact/plugins/specialdates"
