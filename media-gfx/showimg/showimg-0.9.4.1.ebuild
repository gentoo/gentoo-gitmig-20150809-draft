# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/showimg/showimg-0.9.4.1.ebuild,v 1.3 2005/03/20 15:06:45 carlo Exp $

inherit kde

MY_PV="${PV/?.?.?.?/${PV%.*}-${PV##*.}}"
MY_P="${PN}-${MY_PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="feature-rich image viewer for KDE"
HOMEPAGE="http://www.jalix.org/projects/showimg/"
SRC_URI="http://www.jalix.org/projects/showimg/download/${MY_PV}/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc ~ppc ~amd64"
IUSE=""


DEPEND="|| ( kde-base/libkonq kde-base/kdebase )
	media-libs/libkexif
	media-plugins/kipi-plugins"
need-kde 3.1

src_compile(){
	local myconf="--enable-libkipi"
	kde_src_compile all
}