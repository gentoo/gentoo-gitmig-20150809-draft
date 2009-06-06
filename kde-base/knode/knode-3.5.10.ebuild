# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/knode/knode-3.5.10.ebuild,v 1.4 2009/06/06 13:16:59 maekke Exp $

KMNAME=kdepim
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="A newsreader for KDE"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=">=kde-base/libkdepim-${PV}:${SLOT}
>=kde-base/libkdenetwork-${PV}:${SLOT}
>=kde-base/kontact-${PV}:${SLOT}
>=kde-base/libkmime-${PV}:${SLOT}
>=kde-base/libkpgp-${PV}:${SLOT}"

RDEPEND="${DEPEND}"

KMCOPYLIB="
	libkdepim libkdepim
	libkpinterfaces kontact/interfaces
	libkmime libkmime
	libkpgp libkpgp"
KMEXTRACTONLY="
	libkdepim/
	libkdenetwork/
	kontact/interfaces
	libkmime
	libkpgp
	libemailfunctions"
KMEXTRA="kontact/plugins/knode" # We add here the kontact's plugin instead of compiling it with kontact because it needs a lot of this programs deps.
