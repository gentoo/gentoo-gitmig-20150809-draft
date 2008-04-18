# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ktouch/ktouch-3.5.8.ebuild,v 1.8 2008/04/18 21:29:22 cla Exp $
KMNAME=kdeedu
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE: A program that helps you to learn and practice touch typing"
HOMEPAGE="http://ktouch.sourceforge.net/"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""
DEPEND="$(deprange 3.5.7 $MAXKDEVER kde-base/libkdeedu)"

RDEPEND="${DEPEND}"

KMEXTRACTONLY="libkdeedu/kdeeduplot"
KMCOPYLIB="libkdeeduplot libkdeedu/kdeeduplot"

src_unpack() {
	kde-meta_src_unpack

	sed -i -e 's:Miscellaneous:X-Miscellaneous:' \
		"${S}/${PN}/${PN}.desktop" || sed "Sed to fix .desktop files failed."
}
