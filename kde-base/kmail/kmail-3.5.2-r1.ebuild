# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kmail/kmail-3.5.2-r1.ebuild,v 1.2 2006/04/22 12:06:45 corsair Exp $

KMNAME=kdepim
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE mail client"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
DEPEND="$(deprange 3.5.0-r3 $MAXKDEVER kde-base/libkdenetwork)
	$(deprange $PV $MAXKDEVER kde-base/libkdepim)
	$(deprange $PV $MAXKDEVER kde-base/libkpimidentities)
	$(deprange 3.5.1 $MAXKDEVER kde-base/mimelib)
	$(deprange 3.5.0-r3 $MAXKDEVER kde-base/libksieve)
	$(deprange $PV $MAXKDEVER kde-base/certmanager)
	$(deprange $PV $MAXKDEVER kde-base/libkcal)
	$(deprange $PV $MAXKDEVER kde-base/kontact)"
RDEPEND="${DEPEND}
	crypt? ( app-crypt/pinentry )
	$(deprange $PV $MAXKDEVER kde-base/kdepim-kioslaves)
	$(deprange 3.5.1 $MAXKDEVER kde-base/kmailcvt)
	$(deprange-dual $PV $MAXKDEVER kde-base/kdebase-kioslaves)
	$(deprange-dual $PV $MAXKDEVER kde-base/kcontrol)" # for the "looknfeel" icon, and probably others.

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

PATCHES="${FILESDIR}/kmail-3.5.2-imap-fixes.diff
	${FILESDIR}/kmail-3.5.2-misc-fixes.diff
	${FILESDIR}/kmail-3.5-ham_spam_icons.diff"
