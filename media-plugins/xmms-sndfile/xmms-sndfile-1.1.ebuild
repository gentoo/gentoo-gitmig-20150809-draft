# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-sndfile/xmms-sndfile-1.1.ebuild,v 1.6 2004/10/19 23:24:06 eradicator Exp $

MY_PN=${PN/-/_}
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Xmms_sndfile is a libsndfile plugin for XMMS"
HOMEPAGE="http://www.mega-nerd.com/xmms_sndfile/"
SRC_URI="http://www.zipworld.com.au/~erikd/XMMS/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

IUSE=""

DEPEND="media-libs/libsndfile
	media-sound/xmms"

src_install() {
	make DESTDIR=${D} libdir=/usr/lib/xmms/Input install || die
	dodoc AUTHORS COPYING NEWS README ChangeLog INSTALL TODO
}
