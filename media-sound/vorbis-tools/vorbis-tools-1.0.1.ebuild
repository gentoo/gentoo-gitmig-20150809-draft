# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/vorbis-tools/vorbis-tools-1.0.1.ebuild,v 1.27 2008/01/07 14:26:40 drac Exp $

IUSE="nls flac speex"

inherit toolchain-funcs flag-o-matic

DESCRIPTION="tools for using the Ogg Vorbis sound file format"
HOMEPAGE="http://www.vorbis.com/"
SRC_URI="http://www.vorbis.com/files/${PV}/unix/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="mips"

RDEPEND=">=media-libs/libvorbis-1.0
	>=media-libs/libao-0.8.2
	>=net-misc/curl-7.9
	!mips? ( speex? ( media-libs/speex ) )
	flac? ( ~media-libs/flac-1.1.2 )"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_compile() {
	use hppa && [ "`gcc-fullversion`" == "3.3.2" ] && replace-flags -march=2.0 -march=1.0
	local myconf

	# --with-flac is not supported.  See bug #49763
	use flac || myconf="${myconf} --without-flac"

	econf \
		`if ! use mips; then use_with speex; fi` \
		`use_enable nls` \
		${myconf} \
		|| die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die

	rm -rf "${D}"/usr/share/doc
	dodoc AUTHORS README
	docinto ogg123
	dodoc ogg123/ogg123rc-example
}
