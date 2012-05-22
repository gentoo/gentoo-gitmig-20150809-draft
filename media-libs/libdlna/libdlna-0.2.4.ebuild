# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdlna/libdlna-0.2.4.ebuild,v 1.3 2012/05/22 12:00:48 johu Exp $

EAPI=4
inherit eutils multilib

DESCRIPTION="A reference open-source implementation of DLNA (Digital Living Network Alliance) standards."
HOMEPAGE="http://libdlna.geexbox.org"
SRC_URI="http://libdlna.geexbox.org/releases/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=virtual/ffmpeg-0.6.90"
RDEPEND="${DEPEND}"

src_configure() {
	# I can't use econf
	# --host is not implemented in ./configure file
	./configure \
		--prefix=/usr \
		--libdir=/usr/$(get_libdir) \
		--disable-static \
		|| die "./configure failed"
}

src_compile() {
	# not parallel safe, error "cannot find -ldlna"
	emake -j1
}

#src_install() {
#	emake DESTDIR="${D}" install || die "emake install failed."
#	dodoc README AUTHORS ChangeLog || die
#}
