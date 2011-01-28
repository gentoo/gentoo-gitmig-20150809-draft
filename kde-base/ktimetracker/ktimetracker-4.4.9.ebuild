# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ktimetracker/ktimetracker-4.4.9.ebuild,v 1.3 2011/01/28 19:49:39 tomka Exp $

EAPI="3"

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="KTimeTracker tracks time spent on various tasks."
KEYWORDS="amd64 ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug +handbook"

RDEPEND="
	$(add_kdebase_dep kdepim-kresources)
	$(add_kdebase_dep kdepimlibs)
	$(add_kdebase_dep libkdepim)
	x11-libs/libXScrnSaver
"
DEPEND="${RDEPEND}
	x11-proto/scrnsaverproto
"

KMEXTRACTONLY="
	kresources/
"

KMLOADLIBS="libkdepim"

src_unpack() {
	if use kontact; then
		KMEXTRA="${KMEXTRA} kontact/plugins/ktimetracker"
	fi

	kde4-meta_src_unpack
}
