# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/vorbis-tools/vorbis-tools-1.0.1.ebuild,v 1.7 2004/04/01 08:42:50 eradicator Exp $

inherit gcc flag-o-matic

DESCRIPTION="tools for using the Ogg Vorbis sound file format"
HOMEPAGE="http://www.xiph.org/ogg/vorbis/index.html"
SRC_URI="http://www.vorbis.com/files/${PV}/unix/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~mips"
IUSE="nls flac"

RDEPEND=">=media-libs/libvorbis-1.0
	>=media-libs/libao-0.8.2
	>=net-misc/curl-7.9
	flac? ( media-libs/flac )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_compile() {
	use hppa && [ "`gcc-fullversion`" == "3.3.2" ] && replace-flags -march=2.0 -march=1.0
	econf \
		`use_enable nls` \
		`use_with flac` \
		|| die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	rm -rf ${D}/usr/share/doc
	dodoc AUTHORS README
	docinto ogg123
	dodoc ogg123/ogg123rc-example
}
