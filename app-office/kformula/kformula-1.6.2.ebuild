# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/kformula/kformula-1.6.2.ebuild,v 1.15 2009/06/30 20:50:42 tampakrap Exp $

MAXKOFFICEVER=1.6.3
KMNAME=koffice
inherit kde-meta eutils

DESCRIPTION="KOffice formula editor."
HOMEPAGE="http://www.koffice.org/"
LICENSE="GPL-2 LGPL-2"

SLOT="3.5"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="$(deprange $PV $MAXKOFFICEVER app-office/koffice-libs)
	|| ( =kde-base/kcontrol-3.5* =kde-base/kdebase-3.5* )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

KMCOPYLIB="
	libkformula lib/kformula
	libkofficecore lib/kofficecore
	libkofficeui lib/kofficeui
	libkopainter lib/kopainter
	libkotext lib/kotext
	libkwmf lib/kwmf
	libkowmf lib/kwmf
	libkstore lib/store"

KMEXTRACTONLY="lib/"

KMEXTRA="filters/kformula"

need-kde 3.4

src_unpack() {
	kde-meta_src_unpack

	# Fixing desktop files, cf. bug 190006
	sed -i -e "s:x-kformula$:x-kformula;:g" "${S}"/kformula/kformula.desktop

	epatch "${FILESDIR}"/${P}-gcc-4.3.patch   # 214365
}
