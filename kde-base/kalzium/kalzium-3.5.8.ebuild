# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kalzium/kalzium-3.5.8.ebuild,v 1.1 2007/10/19 21:54:55 philantrop Exp $
KMNAME=kdeedu
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit flag-o-matic kde-meta

DESCRIPTION="KDE: periodic table of the elements"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="solver"
HOMEPAGE="http://edu.kde.org/kalzium"

DEPEND="$(deprange 3.5.7-r1 $MAXKDEVER kde-base/libkdeedu)
		solver? ( >=dev-ml/facile-1.1 )"

KMEXTRACTONLY="libkdeedu/kdeeduplot
	libkdeedu/kdeeduui"
KMCOPYLIB="libkdeeduplot libkdeedu/kdeeduplot
	libkdeeduui libkdeedu/kdeeduui"

PATCHES="${FILESDIR}/${PN}-3.5.7-copy_string.patch"

src_compile() {
	append-ldflags -Wl,-z,noexecstack

	local myconf="$(use_enable solver ocamlsolver)"

	if use solver ; then
		cd "${S}/${PN}/src/solver"
		emake || die "compiling the ocaml resolver failed"
	fi

	kde-meta_src_compile
}
