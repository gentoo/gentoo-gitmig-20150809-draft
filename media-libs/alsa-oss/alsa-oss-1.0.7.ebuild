# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/alsa-oss/alsa-oss-1.0.7.ebuild,v 1.5 2005/03/19 21:07:37 pylon Exp $

IUSE=""

MY_P=${P/_rc/rc}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Advanced Linux Sound Architecture OSS compatibility layer."
HOMEPAGE="http://www.alsa-project.org/"
SRC_URI="mirror://alsaproject/oss-lib/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ppc sparc x86"

DEPEND="virtual/libc
	>=media-libs/alsa-lib-1.0"

src_install() {
	make DESTDIR="${D}" install || die
}
