# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kontact-specialdates/kontact-specialdates-3.5.9.ebuild,v 1.3 2008/05/12 15:03:46 armin76 Exp $

KMNAME=kdepim
KMNOMODULE=true
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="Special Dates plugin for Kontact: displays a summary of important holidays and calendar events"
KEYWORDS="alpha ~amd64 ~hppa ia64 ~ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=">=kde-base/libkdepim-${PV}:${SLOT}
	>=kde-base/kontact-${PV}:${SLOT}
	>=kde-base/kaddressbook-${PV}:${SLOT}
	>=kde-base/korganizer-${PV}:${SLOT}
	>=kde-base/libkholidays-${PV}:${SLOT}"
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
