# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/alsa-oss/alsa-oss-1.0.12.ebuild,v 1.12 2006/10/18 05:20:14 tsunam Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="1.9"

inherit multilib autotools

MY_P="${P/_rc/rc}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Advanced Linux Sound Architecture OSS compatibility layer."
HOMEPAGE="http://www.alsa-project.org/"
SRC_URI="mirror://alsaproject/oss-lib/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND=">=media-libs/alsa-lib-1.0"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-hardened.patch"
	eautomake
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	sed -i -e 's:\${exec_prefix}/\\$LIB/::' ${D}/usr/bin/aoss
}
