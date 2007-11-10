# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/mktorrent-borg/mktorrent-borg-0.9.7.ebuild,v 1.1 2007/11/10 16:15:31 armin76 Exp $

inherit eutils

DESCRIPTION="Console .torrent file creator. It support Multi Trackers (tier groups)"
HOMEPAGE="http://borg.uu3.net/~borg/"
SRC_URI="ftp://borg.uu3.net/pub/unix/mktorrent/mktorrent-${PV}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

S="${WORKDIR}/${PN%-borg}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}-CFLAGS.patch"
}

src_install() {
	newbin mktorrent mktorrent-borg || die "newbin failed"
	dodoc CHANGES
}
