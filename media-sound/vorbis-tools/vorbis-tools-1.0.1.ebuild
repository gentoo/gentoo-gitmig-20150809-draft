# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/vorbis-tools/vorbis-tools-1.0.1.ebuild,v 1.15 2004/07/30 02:25:16 tgall Exp $

inherit gcc flag-o-matic

DESCRIPTION="tools for using the Ogg Vorbis sound file format"
HOMEPAGE="http://www.xiph.org/ogg/vorbis/index.html"
SRC_URI="http://www.vorbis.com/files/${PV}/unix/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~ppc sparc ~alpha hppa amd64 mips ppc64"
IUSE="nls flac speex"

RDEPEND=">=media-libs/libvorbis-1.0
	>=media-libs/libao-0.8.2
	>=net-misc/curl-7.9
	!mips? ( speex? ( media-libs/speex ) )
	flac? ( media-libs/flac )"

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
	make DESTDIR=${D} install || die

	rm -rf ${D}/usr/share/doc
	dodoc AUTHORS README
	docinto ogg123
	dodoc ogg123/ogg123rc-example
}
