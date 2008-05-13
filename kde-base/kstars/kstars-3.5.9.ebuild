# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kstars/kstars-3.5.9.ebuild,v 1.5 2008/05/13 03:41:40 jer Exp $
KMNAME=kdeedu
EAPI="1"
inherit kde-meta

DESCRIPTION="KDE Desktop Planetarium"
KEYWORDS="alpha ~amd64 hppa ia64 ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=">=kde-base/libkdeedu-${PV}:${SLOT}"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="libkdeedu/extdate
	libkdeedu/kdeeduplot
	libkdeedu/kdeeduui"
KMCOPYLIB="libextdate libkdeedu/extdate
		libkdeeduplot libkdeedu/kdeeduplot
		libkdeeduui libkdeedu/kdeeduui"

src_unpack () {
	kde-meta_src_unpack
	cd "${S}"
}
