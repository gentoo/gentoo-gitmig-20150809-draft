# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/codeine/codeine-1.0_rc1.ebuild,v 1.1 2005/07/21 08:16:04 greg_g Exp $

inherit kde

MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Simple KDE frontend for xine-lib."
HOMEPAGE="http://kde-apps.org/content/show.php?content=17161"
SRC_URI="http://www.methylblue.com/codeine/${MY_P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="media-libs/xine-lib"

DEPEND="${RDEPEND}
	dev-util/scons"

need-kde 3.3

src_compile(){
	local myconf="prefix=/usr"
	use debug && myconf="${myconf} debug=full"

	scons configure ${myconf} || die
	scons || die
}

src_install() {
	DESTDIR="${D}" scons install || die
	dodoc README ChangeLog VERSION
}
