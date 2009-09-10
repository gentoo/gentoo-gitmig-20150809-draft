# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-ImageSlideShow/desklet-ImageSlideShow-0.8-r1.ebuild,v 1.1 2009/09/10 02:19:55 nixphoeni Exp $

DESKLET_NAME="${PN#desklet-}"

inherit gdesklets

DESCRIPTION="ImageSlideShow Control for gDesklets"
HOMEPAGE="http://gdesklets.de/index.php?q=control/view/211"
SRC_URI="${SRC_URI/\/desklets//controls}"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="${RDEPEND} dev-python/imaging"
DOCS="MANIFEST README"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/${DESKLET_NAME}-${PV}-cache-dir.patch"
}
