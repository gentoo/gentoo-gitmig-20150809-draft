# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/konsolekalendar/konsolekalendar-3.4.0_beta1.ebuild,v 1.1 2005/01/15 02:24:36 danarmak Exp $

KMNAME=kdepim
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="A command line interface to KDE calendars"
KEYWORDS="~x86"
IUSE=""
DEPEND="$(deprange-dual $PV $MAXKDEVER kde-base/libkcal)
$(deprange-dual $PV $MAXKDEVER kde-base/libkdepim)"
OLDDEPEND="~kde-base/libkcal-$PV ~kde-base/libkdepim-$PV"

KMCOPYLIB="libkcal libkcal
	libkdepim libkdepim"
# libkcal is installed because a lot of headers are needed, but it don't have to be compiled
KMEXTRACTONLY="
	libkcal/
	libkdepim/"

