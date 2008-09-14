# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkpimidentities/libkpimidentities-3.5.10.ebuild,v 1.1 2008/09/14 00:00:26 carlo Exp $

KMNAME=kdepim
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="KDE PIM identities library"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""
DEPEND=">=kde-base/certmanager-${PV}:${SLOT}
		>=kde-base/libkdepim-${PV}:${SLOT}
	>=kde-base/libkmime-${PV}:${SLOT}"

KMCOPYLIB="
	libkleopatra certmanager/lib/
	libkdepim libkdepim/
	libkmime libkmime"
KMEXTRACTONLY="
	libkdepim/
	certmanager/
	libkmime/kmime_util.h"
KMCOMPILEONLY="
	libemailfunctions/"
