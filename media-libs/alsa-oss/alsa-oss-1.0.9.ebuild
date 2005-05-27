# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/alsa-oss/alsa-oss-1.0.9.ebuild,v 1.1 2005/05/27 20:37:58 luckyduck Exp $

inherit multilib

DESCRIPTION="Advanced Linux Sound Architecture OSS compatibility layer."
HOMEPAGE="http://www.alsa-project.org/"
SRC_URI="mirror://alsaproject/oss-lib/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="virtual/libc
	>=media-libs/alsa-lib-1.0"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dosed "s:/usr/$(get_libdir)/libaoss.so:libaoss.so:g" /usr/bin/aoss
}
