# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/showimg/showimg-0.9.4.ebuild,v 1.1 2004/11/30 18:24:51 carlo Exp $

inherit kde

DESCRIPTION="feature-rich image viewer for KDE"
SRC_URI="http://www.jalix.org/projects/showimg/download/${PVR}/${P}.tar.bz2"
HOMEPAGE="http://www.jalix.org/projects/showimg/"

LICENSE="GPL-2"
KEYWORDS="~x86"

IUSE=""
SLOT="0"

DEPEND="kde-base/kdebase
	kipi-plugins"
RDEPEND="kde-base/kdebase
	kipi-plugins"
need-kde 3.1

src_compile(){
	local myconf="--enable-libkipi"
	kde_src_compile all
}