# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ffmpeg2theora/ffmpeg2theora-0.21.ebuild,v 1.3 2008/10/14 16:34:14 aballier Exp $

inherit eutils

DESCRIPTION="A simple converter to create Ogg Theora files."
HOMEPAGE="http://www.v2v.cc/~j/ffmpeg2theora/index.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
# fails because of circular redirection:
# SRC_URI="http://www.v2v.cc/~j/ffmpeg2theora/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=media-video/ffmpeg-0.4.9_p20070616-r20
	>=media-libs/libvorbis-1.1
	>=media-libs/libogg-1.1
	>=media-libs/libtheora-1.0_beta1"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_setup() {
	local fail="Re-emerge media-libs/libtheora with USE encode."

	if ! built_with_use media-libs/libtheora encode; then
		eerror "${fail}"
		die "${fail}"
	fi
	if ! built_with_use --missing true media-video/ffmpeg vhook; then
		eerror "${PN} requires ffmpeg to be built with the vhook useflag."
		die "Please reinstall media-video/ffmpeg with the vhook useflag enabled"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog README TODO
#	newdoc kino_export/README README.kino_export
#	exeinto /usr/share/kino/scripts/exports
#	doexe kino_export/ffmpeg2theora.sh
}
