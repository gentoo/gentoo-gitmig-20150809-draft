# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/muse/muse-0.8.1-r1.ebuild,v 1.2 2004/03/03 18:50:03 eradicator Exp $

inherit eutils

MY_P=${PN/muse/MuSE}-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Multiple Streaming Engine, an icecast source streamer"
SRC_URI="http://savannah.nongnu.org/download/muse/${MY_P}.tar.gz"
HOMEPAGE="http://muse.dyne.org/"

KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"
IUSE="ncurses gtk debug"

DEPEND="media-sound/lame
	media-libs/libvorbis
	sys-libs/zlib
	sys-apps/sed
	ncurses? ( sys-libs/ncurses )
	gtk? ( =x11-libs/gtk+-1*
	>=dev-libs/glib-1 )"

src_unpack() {
	unpack ${MY_P}.tar.gz
	cd ${S}
	epatch ${FILESDIR}/${P}-strings.patch
}

src_compile() {
	econf \
	`use_with gtk x` \
	`use_with ncurses rubik` \
	`use_enable debug` || die "econf failed"

	emake CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" || die "emake failed"
}

src_install() {
	dobin muse
	dodoc AUTHORS ChangeLog NEWS README TODO USAGE
}

pkg_postinst() {
	einfo
	einfo "You may want to have a look at /usr/share/doc/${PF}/USAGE.gz for more info."
	einfo
}
