# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/showimg/showimg-0.9.4.ebuild,v 1.5 2005/01/05 02:23:54 cryos Exp $

inherit kde

DESCRIPTION="feature-rich image viewer for KDE"
SRC_URI="http://www.jalix.org/projects/showimg/download/${PVR}/${P}.tar.bz2"
HOMEPAGE="http://www.jalix.org/projects/showimg/"

LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"

IUSE=""
SLOT="0"

DEPEND="kde-base/kdebase
	media-plugins/kipi-plugins"
RDEPEND="kde-base/kdebase
	media-plugins/kipi-plugins"
need-kde 3.1

src_compile(){
	local myconf="--enable-libkipi"
	kde_src_compile all
}