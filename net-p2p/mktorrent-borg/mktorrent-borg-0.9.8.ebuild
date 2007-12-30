# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/mktorrent-borg/mktorrent-borg-0.9.8.ebuild,v 1.1 2007/12/30 15:45:57 armin76 Exp $

inherit eutils toolchain-funcs

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

	epatch "${FILESDIR}/0.9.8-CFLAGS.patch"
	sed -i -e "s/CC=gcc/CC=$(tc-getCC)/g" Makefile
}

src_install() {
	newbin mktorrent mktorrent-borg || die "newbin failed"
	dodoc CHANGES
}
