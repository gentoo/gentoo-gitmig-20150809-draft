# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkdepim/libkdepim-3.4.1.ebuild,v 1.5 2005/07/01 21:17:04 pylon Exp $

KMNAME=kdepim
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="common library for KDE PIM apps"
KEYWORDS="amd64 ppc ppc64 ~sparc x86"
IUSE=""
OLDDEPEND="~kde-base/libkcal-$PV"
DEPEND="
$(deprange $PV $MAXKDEVER kde-base/libkcal)"

KMCOPYLIB="libkcal libkcal"
KMEXTRA="libemailfunctions/"
