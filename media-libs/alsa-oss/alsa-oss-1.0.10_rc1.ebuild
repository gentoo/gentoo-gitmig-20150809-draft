# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/alsa-oss/alsa-oss-1.0.10_rc1.ebuild,v 1.1 2005/08/25 00:10:03 flameeyes Exp $

inherit multilib

MY_P="${P/_rc/rc}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Advanced Linux Sound Architecture OSS compatibility layer."
HOMEPAGE="http://www.alsa-project.org/"
SRC_URI="mirror://alsaproject/oss-lib/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="virtual/libc
	>=media-libs/alsa-lib-1.0"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	sed -i -e "s:/usr/$(get_libdir)/libaoss.so:libaoss.so:g" ${D}/usr/bin/aoss
}
