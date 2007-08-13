# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kpilot/kpilot-3.5.7.ebuild,v 1.2 2007/08/13 12:24:31 gustavoz Exp $

KMNAME=kdepim
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KPilot - HotSync software for KDE."
KEYWORDS="~amd64 ~ia64 ~ppc sparc ~x86 ~x86-fbsd"
IUSE=""
DEPEND=">=app-pda/pilot-link-0.12.0
	dev-libs/libmal
$(deprange $PV $MAXKDEVER kde-base/libkcal)
$(deprange $PV $MAXKDEVER kde-base/libkdepim)
$(deprange $PV $MAXKDEVER kde-base/kontact)"

RDEPEND="${DEPEND}"

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
