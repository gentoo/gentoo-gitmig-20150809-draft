# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kmail/kmail-3.5.7-r2.ebuild,v 1.7 2007/08/11 15:30:34 armin76 Exp $

KMNAME=kdepim
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

SRC_URI="${SRC_URI}
	mirror://gentoo/kdepim-3.5-patchset-04.tar.bz2"

RESTRICT="test"

DESCRIPTION="KMail is the email component of Kontact, the integrated personal information manager of KDE."
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="crypt"
DEPEND="$(deprange $PV $MAXKDEVER kde-base/libkdenetwork)
	$(deprange $PV $MAXKDEVER kde-base/libkdepim)
	$(deprange $PV $MAXKDEVER kde-base/libkpimidentities)
	$(deprange $PV $MAXKDEVER kde-base/mimelib)
	$(deprange $PV $MAXKDEVER kde-base/libksieve)
	$(deprange $PV $MAXKDEVER kde-base/certmanager)
	$(deprange $PV $MAXKDEVER kde-base/libkcal)
	$(deprange $PV $MAXKDEVER kde-base/kontact)
	$(deprange 3.5.4 $MAXKDEVER kde-base/libkpgp)
	$(deprange $PV $MAXKDEVER kde-base/libkmime)"
RDEPEND="${DEPEND}
	crypt? ( app-crypt/pinentry )
	$(deprange $PV $MAXKDEVER kde-base/kdepim-kioslaves)
	$(deprange 3.5.5 $MAXKDEVER kde-base/kmailcvt)
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
KMEXTRA="plugins/kmail/
	kontact/plugins/kmail/" # We add here the kontact's plugin instead of compiling it with kontact because it needs a lot of this programs deps.

src_install() {
	kde-meta_src_install
	# Install KMail icons with libkdepim to work around bug #136810.
	#find ${D}/${KDEDIR}/share/icons/hicolor/ -name "kmail\.png" -exec rm '{}' \;
	rm ${D}/${KDEDIR}/share/icons/hicolor/{16x16,22x22,32x32,48x48,64x64,128x128}/apps/kmail.png || die "bääh"
}
