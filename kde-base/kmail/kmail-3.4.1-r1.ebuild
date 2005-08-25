# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kmail/kmail-3.4.1-r1.ebuild,v 1.6 2005/08/25 19:47:49 gustavoz Exp $

KMNAME=kdepim
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE mail client"
KEYWORDS="~amd64 ppc ppc64 sparc x86"
IUSE=""
DEPEND="$(deprange $PV $MAXKDEVER kde-base/libkdenetwork)
$(deprange $PV $MAXKDEVER kde-base/libkdepim)
$(deprange $PV $MAXKDEVER kde-base/libkpimidentities)
$(deprange $PV $MAXKDEVER kde-base/mimelib)
$(deprange $PV $MAXKDEVER kde-base/libksieve)
$(deprange $PV $MAXKDEVER kde-base/certmanager)
$(deprange $PV $MAXKDEVER kde-base/libkcal)
$(deprange $PV $MAXKDEVER kde-base/kontact)"
RDEPEND="${DEPEND}
$(deprange $PV $MAXKDEVER kde-base/kdepim-kioslaves)
$(deprange $PV $MAXKDEVER kde-base/kmailcvt)
$(deprange-dual $PV $MAXKDEVER kde-base/kdebase-kioslaves)"

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

PATCHES="${FILESDIR}/kmail-3.4.1-shift+click-crash.diff"
