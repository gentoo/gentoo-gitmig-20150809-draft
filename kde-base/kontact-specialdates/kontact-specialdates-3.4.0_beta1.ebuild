# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kontact-specialdates/kontact-specialdates-3.4.0_beta1.ebuild,v 1.1 2005/01/18 20:51:52 danarmak Exp $

KMNAME=kdepim
KMNOMODULE=true
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="Special Dates plugin for Kontact: displays a summary of important holidays and calendar events"
KEYWORDS="~x86"
IUSE=""

DEPEND="
$(deprange-dual $PV $MAXKDEVER kde-base/libkdepim)
$(deprange-dual $PV $MAXKDEVER kde-base/kontact)
$(deprange-dual $PV $MAXKDEVER kde-base/kaddressbook)
$(deprange-dual $PV $MAXKDEVER kde-base/korganizer)
$(deprange-dual $PV $MAXKDEVER kde-base/libkholidays)"
RDEPEND="$DEPEND
$(deprange-dual $PV $MAXKDEVER kde-base/kmail)" # only to enable send mail functionality

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
