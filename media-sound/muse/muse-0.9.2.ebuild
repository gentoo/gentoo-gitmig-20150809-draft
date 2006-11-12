# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/muse/muse-0.9.2.ebuild,v 1.1 2006/11/12 19:36:29 aballier Exp $

inherit eutils

MY_P=${PN/muse/MuSE}-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Multiple Streaming Engine, an icecast source streamer"
SRC_URI="ftp://ftp.dyne.org/muse/releases/${MY_P}.tar.gz"
HOMEPAGE="http://muse.dyne.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="gtk debug"

DEPEND="media-sound/lame
	media-libs/libvorbis
	media-libs/libsndfile
	media-libs/libogg
	sys-libs/zlib
	sys-apps/sed
	gtk? ( =x11-libs/gtk+-2*
	>=dev-libs/glib-2 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}/${P}-asneeded.patch"
}

src_compile() {
	econf \
		$(use_enable debug) \
		$(use_enable gtk gtk2) \
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
	einfo
	einfo "You may want to have a look at /usr/share/doc/${PF}/README.gz"
	einfo "for more info."
	einfo
}
