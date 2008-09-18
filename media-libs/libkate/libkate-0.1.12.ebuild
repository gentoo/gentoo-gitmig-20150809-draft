# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libkate/libkate-0.1.12.ebuild,v 1.2 2008/09/18 20:11:06 maekke Exp $

DESCRIPTION="Codec for karaoke and text encapsulation for Ogg"
HOMEPAGE="http://code.google.com/p/libkate/"
SRC_URI="http://libkate.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="media-libs/libogg
	media-libs/libpng"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/flex
	sys-devel/bison"

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README
	# Remove useless doc
	rm -rf "${D}/usr/share/doc/${PN}"
	use doc && dohtml -r doc/html/*
}
