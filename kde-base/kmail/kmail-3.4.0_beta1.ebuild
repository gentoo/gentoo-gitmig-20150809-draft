# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kmail/kmail-3.4.0_beta1.ebuild,v 1.3 2005/01/21 16:19:39 danarmak Exp $

KMNAME=kdepim
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE mail client"
KEYWORDS="~x86"
IUSE=""
DEPEND="$(deprange-dual $PV $MAXKDEVER kde-base/libkdenetwork)
$(deprange-dual $PV $MAXKDEVER kde-base/libkdepim)
$(deprange-dual $PV $MAXKDEVER kde-base/libkpimidentities)
$(deprange-dual $PV $MAXKDEVER kde-base/mimelib)
$(deprange-dual $PV $MAXKDEVER kde-base/libksieve)
$(deprange-dual $PV $MAXKDEVER kde-base/certmanager)
$(deprange-dual $PV $MAXKDEVER kde-base/libkcal)
$(deprange-dual $PV $MAXKDEVER kde-base/kontact)"
RDEPEND="${DEPEND}
$(deprange-dual $PV $MAXKDEVER kde-base/kdepim-kioslaves)
$(deprange-dual $PV $MAXKDEVER kde-base/kdebase-kioslaves)
$(deprange-dual $PV $MAXKDEVER kde-base/kmailcvt)"

KMCOPYLIB="
	libkdepim libkdepim/
	libkpimidentities libkpimidentities/
	libmimelib mimelib/
	libksieve libksieve/
	libkleopatra certmanager/lib/
	libkcal libkcal
	libkpinterfaces kontact/interfaces/
	libkmime libkmime
	libkpgp libkpgp"
KMEXTRACTONLY="
	libkdenetwork/
	libkdepim/
	libkpimidentities/
	libksieve/
	libkcal/
	mimelib/
	certmanager/
	korganizer/korganizeriface.h
	kontact/interfaces/
	libkmime/
	libkpgp
	dcopidlng"
KMCOMPILEONLY="libemailfunctions"
# the kmail plugins are installed with kmail
KMEXTRA="
	plugins/kmail/
	kontact/plugins/kmail/" # We add here the kontact's plugin instead of compiling it with kontact because it needs a lot of this programs deps.

