# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkcal/libkcal-3.5.5.ebuild,v 1.8 2006/12/11 19:06:30 kloeri Exp $

KMNAME=kdepim
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE kcal library for korganizer etc"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="$(deprange $PV $MAXKDEVER kde-base/ktnef)"
RDEPEND="${DEPEND}"

KMCOPYLIB="libktnef ktnef/lib"
KMEXTRACTONLY="libkdepim/email.h"
KMCOMPILEONLY="libemailfunctions/"
