# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/codeine/codeine-1.0_beta1.ebuild,v 1.1 2004/10/24 05:40:28 chriswhite Exp $

inherit kde

MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Simple KDE frontend for xine-lib"
HOMEPAGE="http://kde-apps.org/content/show.php?content=17161"
SRC_URI="http://www.methylblue.com/codeine/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE="debug"

DEPEND="media-libs/xine-lib"
need-kde 3.1

src_compile(){
	local myconf=""

	use debug && myconf="${myconf} --debug"

	./configure $myconf
	emake
}
src_install() {
	make INSTALL_ROOT="${D}" install || die "make install failed"
	dodoc README
}
