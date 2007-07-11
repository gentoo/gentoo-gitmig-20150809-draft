# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/muse/muse-0.9.1.ebuild,v 1.6 2007/07/11 19:30:24 mr_bones_ Exp $

inherit eutils

MY_P=${PN/muse/MuSE}-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Multiple Streaming Engine, an icecast source streamer"
SRC_URI="ftp://ftp.dyne.org/muse/releases/${MY_P}.tar.gz"
HOMEPAGE="http://muse.dyne.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc sparc x86 amd64"
IUSE="ncurses gtk debug"

DEPEND="media-sound/lame
	media-libs/libvorbis
	sys-libs/zlib
	sys-apps/sed
	ncurses? ( sys-libs/ncurses )
	gtk? ( =x11-libs/gtk+-1*
	>=dev-libs/glib-1 )"
RESTRICT="mirror"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-include.patch
	epatch ${FILESDIR}/${P}-miscfixes.patch
}

src_compile() {
	econf \
		$(use_enable debug) \
		$(use_with gtk x) \
		$(use_with ncurses rubik) \
		|| die "econf failed"

	emake CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS} -fpermissive" \
		|| die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	rm -rf ${D}/usr/doc
	dodoc AUTHORS ChangeLog NEWS README TODO KNOWN-BUGS USAGE
}

pkg_postinst() {
	elog
	elog "You may want to have a look at /usr/share/doc/${PF}/README.gz"
	elog "for more info."
	elog
}
