# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kooka/kooka-3.5.9.ebuild,v 1.2 2008/05/12 17:25:58 armin76 Exp $

KMNAME=kdegraphics
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="Kooka is a KDE application which provides access to scanner hardware"
KEYWORDS="alpha ~amd64 ia64 ~ppc ~ppc64 sparc ~x86"
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
