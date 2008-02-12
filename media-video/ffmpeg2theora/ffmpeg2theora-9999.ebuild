# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ffmpeg2theora/ffmpeg2theora-9999.ebuild,v 1.1 2008/02/12 14:46:01 drac Exp $

ESVN_REPO_URI="http://svn.xiph.org/trunk/${PN}"

inherit autotools eutils subversion

DESCRIPTION="A simple converter to create Ogg Theora files."
HOMEPAGE="http://www.v2v.cc/~j/ffmpeg2theora"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=">=media-video/ffmpeg-0.4.9_p20070616-r1
	>=media-libs/libvorbis-1.1
	>=media-libs/libogg-1.1
	>=media-libs/libtheora-1.0_beta1"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/subversion"

pkg_setup() {
	local fail="Re-emerge media-libs/libtheora with USE encode."
	if ! built_with_use media-libs/libtheora encode; then
		eerror "${fail}"
		die "${fail}"
	fi
}

src_unpack() {
	subversion_src_unpack
	eautoreconf
}

src_compile() {
	econf --enable-maintainer-mode
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog README TODO
}
