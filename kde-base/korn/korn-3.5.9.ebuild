# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/korn/korn-3.5.9.ebuild,v 1.5 2008/05/12 20:03:38 ranger Exp $

KMNAME=kdepim
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="KDE mailbox checker"
KEYWORDS="alpha ~amd64 ~hppa ia64 ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=">=kde-base/mimelib-${PV}:${SLOT}
>=kde-base/libkmime-${PV}:${SLOT}"
RDEPEND="${DEPEND}
	|| ( >=kde-base/kdebase-kioslaves-${PV}:${SLOT} >=kde-base/kdebase-${PV}:${SLOT} )
	>=kde-base/kdepim-kioslaves-${PV}:${SLOT}"

KMCOPYLIB="libmimelib mimelib
	libkmime libkmime"
# libkcal is installed because a lot of headers are needed, but it doesn't have to be compiled
KMEXTRACTONLY="
	mimelib/
	libkmime/
	libkdenetwork/"
