# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-volnorm/xmms-volnorm-0.8.1.ebuild,v 1.8 2006/02/07 21:13:25 agriffis Exp $

IUSE=""

inherit eutils

MY_P=${P/xmms-/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Plugin for XMMS, music will be played at the same volume even if it
is recorded at a different volume level"
#SRC_URI="mirror://sourceforge/volnorm/${MY_P}.tar.gz"
SRC_URI="http://volnorm.sourceforge.net/volnorm-0.8.1.tar.gz"
HOMEPAGE="http://volnorm.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
#~arch: Keep in ~arch as this is a dev version upstream.
KEYWORDS="alpha amd64 ppc sparc x86"

DEPEND="media-sound/xmms"

src_unpack() {
	unpack ${A}

	# see #83138
	cd ${S}
	epatch ${FILESDIR}/${PV}-gentoo.patch

	autoconf
	libtoolize --copy --force || die "libtoolize failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS BUGS ChangeLog NEWS README RELEASE TODO
}
