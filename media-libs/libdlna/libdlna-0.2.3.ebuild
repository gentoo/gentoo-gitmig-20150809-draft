# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdlna/libdlna-0.2.3.ebuild,v 1.3 2011/11/11 12:36:39 aballier Exp $

EAPI=2
inherit eutils multilib

DESCRIPTION="A reference open-source implementation of DLNA (Digital Living Network Alliance) standards."
HOMEPAGE="http://libdlna.geexbox.org"
SRC_URI="http://libdlna.geexbox.org/releases/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=virtual/ffmpeg-0.6.90"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}-libavcodec-libavformat-include-paths.patch" \
		"${FILESDIR}/${P}-ffmpeg_api.patch"
}

src_configure() {
	# I can't use econf
	# --host is not implemented in ./configure file
	./configure \
		--prefix=/usr \
		--libdir=/usr/$(get_libdir) \
		|| die "./configure failed"
}

src_compile() {
	# not parallel safe, error "cannot find -ldlna"
	emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc README AUTHORS ChangeLog || die
}
