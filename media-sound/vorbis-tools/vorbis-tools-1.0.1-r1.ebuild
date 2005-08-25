# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/vorbis-tools/vorbis-tools-1.0.1-r1.ebuild,v 1.1 2005/08/25 14:05:08 flameeyes Exp $

IUSE="nls flac speex"

inherit toolchain-funcs flag-o-matic

DESCRIPTION="tools for using the Ogg Vorbis sound file format"
HOMEPAGE="http://www.xiph.org/ogg/vorbis/index.html"
SRC_URI="http://www.vorbis.com/files/${PV}/unix/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc-macos ~ppc64 ~sparc ~x86"

RDEPEND=">=media-libs/libvorbis-1.0
	>=media-libs/libao-0.8.2
	>=net-misc/curl-7.9
	speex? ( media-libs/speex )
	flac? ( media-libs/flac )"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-largefile.patch
	autoconf || die "autoconf failed"
}

src_compile() {
	use hppa && [ "`gcc-fullversion`" == "3.3.2" ] && replace-flags -march=2.0 -march=1.0
	use ppc-macos && use speex && append-flags -I/usr/include/speex
	local myconf

	# --with-flac is not supported.  See bug #49763
	use flac || myconf="${myconf} --without-flac"

	econf \
		$(use_with speex) \
		$(use_enable nls) \
		${myconf} \
		|| die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die

	rm -rf ${D}/usr/share/doc
	dodoc AUTHORS README
	docinto ogg123
	dodoc ogg123/ogg123rc-example
}
