# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-sndfile/xmms-sndfile-1.2.ebuild,v 1.1 2004/02/01 07:10:32 eradicator Exp $

MY_PN=${PN/-/_}
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Xmms_sndfile is a libsndfile plugin for XMMS"
HOMEPAGE="http://www.zipworld.com.au/~erikd/XMMS/"
SRC_URI="http://www.zipworld.com.au/~erikd/XMMS/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc"

DEPEND="media-libs/libsndfile
	media-sound/xmms"

src_install() {
	make DESTDIR=${D} libdir=/usr/lib/xmms/Input install || die
	dodoc AUTHORS NEWS README ChangeLog TODO
}
