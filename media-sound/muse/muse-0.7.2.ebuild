# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/muse/muse-0.7.2.ebuild,v 1.3 2003/09/08 07:09:44 msterret Exp $

IUSE="ncurses oggvorbis X"

S=${WORKDIR}/${P/muse/MuSE}

DESCRIPTION="Multiple Streaming Engine, an icecast source streamer"
SRC_URI="http://savannah.nongnu.org/download/muse/${P/muse/MuSE}.tar.gz"
HOMEPAGE="http://muse.dyne.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc
	>=sys-apps/portage-2.0.45-r3
	>=media-sound/lame-3.92
	>=sys-apps/sed-4.0.5
	ncurses? ( >=sys-libs/ncurses-5.2 )
	oggvorbis? ( >=media-libs/libogg-1.0 >=media-libs/libvorbis-1.0-r1 )
	X? ( =x11-libs/gtk+-1* )"

RDEPEND="virtual/glibc
	>=media-sound/lame-3.92
	ncurses? ( >=sys-libs/ncurses-5.2 )
	oggvorbis? ( >=media-libs/libogg-1.0 >=media-libs/libvorbis-1.0-r1 )
	X? ( =x11-libs/gtk+-1* )"

src_compile() {
	local xcmd

	# if media-libs/{libogg,libvorbis} are installed, the configure script
	# will automatically enable oggvorbis support
	if ! use oggvorbis; then
		xcmd="s:\"\$have_\(ogg\|vorbis\)\":\"no\":;"
	fi

	# if sys-libs/ncurses is installed, the configure script will
	# automatically build the ncurses GUI
	if ! use ncurses; then
		xcmd="$xcmd /^GUI_RUBIK/s:true:false:"
	fi

	[ "$xcmd" ] && sed -i "$xcmd" configure

	econf	`use_with X x` \
		--disable-debug

	emake CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" || die "Make failed"
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
