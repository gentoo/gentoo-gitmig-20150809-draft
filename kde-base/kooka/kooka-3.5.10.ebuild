# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kooka/kooka-3.5.10.ebuild,v 1.4 2009/06/06 12:09:50 maekke Exp $

KMNAME=kdegraphics
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="Kooka is a KDE application which provides access to scanner hardware"
KEYWORDS="~alpha amd64 ~hppa ppc ppc64 ~sparc x86"
IUSE=""

DEPEND=">=kde-base/libkscan-${PV}:${SLOT}
	media-libs/tiff"
RDEPEND="${DEPEND}"

KMCOPYLIB="libkscan libkscan"
KMEXTRACTONLY="libkscan"

src_compile() {
	# There's no ebuild for kadmos, and likely will never be since it isn't free.
	myconf="$myconf --without-kadmos"
	kde-meta_src_compile
}
