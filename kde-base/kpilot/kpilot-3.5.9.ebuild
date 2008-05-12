# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kpilot/kpilot-3.5.9.ebuild,v 1.3 2008/05/12 20:01:16 ranger Exp $

KMNAME=kdepim
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="KPilot - HotSync software for KDE."
KEYWORDS="alpha ~amd64 ia64 ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=">=app-pda/pilot-link-0.12.0
		>=dev-libs/libmal-0.44
>=kde-base/libkcal-${PV}:${SLOT}
>=kde-base/libkdepim-${PV}:${SLOT}
>=kde-base/kontact-${PV}:${SLOT}"

RDEPEND="${DEPEND}"

# The tests are broken.
RESTRICT="test"

KMCOPYLIB="
	libkcal libkcal
	libkdepim libkdepim
	libkpinterfaces kontact/interfaces"
# libkcal is installed because a lot of headers are needed, but it don't have to be compiled
KMEXTRACTONLY="
	libkcal/
	libkdepim libkdepim/
	kontact/interfaces/"
KMEXTRA="
	kfile-plugins/palm-databases
	kontact/plugins/kpilot/" # We add here the kontact's plugin instead of compiling it with kontact because it needs a lot of this programs deps.

src_compile() {
	# needed to detect pi-notepad.h, used by the kpilot notepad conduit.
	myconf="${myconf} --with-extra-includes=/usr/include/libpisock"

	kde-meta_src_compile
}
