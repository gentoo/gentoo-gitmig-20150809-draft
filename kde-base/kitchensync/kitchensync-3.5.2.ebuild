# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kitchensync/kitchensync-3.5.2.ebuild,v 1.9 2006/09/03 16:05:33 kloeri Exp $

KMNAME=kdepim
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="Synchronize Data with KDE"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""
DEPEND="$(deprange $PV $MAXKDEVER kde-base/kontact)
$(deprange $PV $MAXKDEVER kde-base/libkcal)"

KMCOPYLIB="
	libkcal libkcal
	libkdepim libkdepim
	libkpinterfaces kontact/interfaces"
KMEXTRACTONLY="
	libkcal/
	libkdepim/
	libkdenetwork/
	kontact/interfaces"

# Disabled by default in kontact/plugins/Makefile.am, so check before enabling - 3.4.0_beta1 -- danarmak
# KMEXTRA="kontact/plugins/kitchensync"
KMEXTRA="kontact/plugins/multisynk"
