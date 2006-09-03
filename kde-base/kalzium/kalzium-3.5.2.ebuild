# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kalzium/kalzium-3.5.2.ebuild,v 1.9 2006/09/03 14:48:56 kloeri Exp $
KMNAME=kdeedu
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE: periodic table of the elements"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""
HOMEPAGE="http://edu.kde.org/kalzium"

DEPEND="$(deprange $PV $MAXKDEVER kde-base/libkdeedu)"

KMEXTRACTONLY="libkdeedu/kdeeduplot
	libkdeedu/kdeeduui"
KMCOPYLIB="libkdeeduplot libkdeedu/kdeeduplot
	libkdeeduui libkdeedu/kdeeduui"

src_compile() {
	local myconf="--disable-ocamlsolver"

	kde-meta_src_compile
}
