# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkdepim/libkdepim-3.4.1.ebuild,v 1.7 2005/10/03 13:49:11 agriffis Exp $

KMNAME=kdepim
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="common library for KDE PIM apps"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"
IUSE=""
OLDDEPEND="~kde-base/libkcal-$PV"
DEPEND="
$(deprange $PV $MAXKDEVER kde-base/libkcal)"

KMCOPYLIB="libkcal libkcal"
KMEXTRA="libemailfunctions/"
