# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libfishsound/libfishsound-1.0.0.ebuild,v 1.2 2010/03/11 11:18:37 ssuominen Exp $

EAPI=2

DESCRIPTION="Simple programming interface for decoding and encoding audio data using vorbis or speex"
HOMEPAGE="http://www.xiph.org/fishsound/"
SRC_URI="http://downloads.xiph.org/releases/libfishsound/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="speex"
# flac

RDEPEND="media-libs/libvorbis
	media-libs/libogg
	speex? ( media-libs/speex )"
# flac? ( media-libs/flac )
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	sed -i \
		-e 's:doxygen:doxygen-dummy:' \
		configure || die
}

src_configure() {
	local myconf=""
	# FLAC pkg-config file is broken and shouldn't append -I/usr/include/FLAC
	# because of e.g. assert.h
	# use flac ||
	myconf="${myconf} --disable-flac"
	use speex || myconf="${myconf} --disable-speex"

	econf \
		--disable-dependency-tracking \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" \
		docdir="${D}/usr/share/doc/${PF}" install || die
	dodoc AUTHORS ChangeLog README
}
