# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-volnorm/xmms-volnorm-0.8.1.ebuild,v 1.1 2004/07/19 18:43:22 eradicator Exp $

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
KEYWORDS="~x86 ~ppc ~alpha ~amd64 ~sparc"

DEPEND="media-sound/xmms"

src_install() {
	make DESTDIR="${D}" install || die

	dodoc AUTHORS BUGS COPYING ChangeLog NEWS INSTALL README RELEASE TODO
}
