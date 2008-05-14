# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkpimidentities/libkpimidentities-3.5.9.ebuild,v 1.6 2008/05/14 14:10:34 corsair Exp $

KMNAME=kdepim
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="KDE PIM identities library"
KEYWORDS="alpha ~amd64 hppa ia64 ppc ppc64 sparc ~x86 ~x86-fbsd"
IUSE=""
DEPEND=">=kde-base/certmanager-${PV}:${SLOT}
		>=kde-base/libkdepim-${PV}:${SLOT}"

RDEPEND="${DEPEND}"

KMCOPYLIB="
	libkleopatra certmanager/lib/
	libkdepim libkdepim/"
KMEXTRACTONLY="
	libkdepim/
	certmanager/"
KMCOMPILEONLY="
	libemailfunctions/"
