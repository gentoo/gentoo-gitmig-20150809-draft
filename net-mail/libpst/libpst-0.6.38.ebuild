# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/libpst/libpst-0.6.38.ebuild,v 1.1 2009/06/22 09:06:06 patrick Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="Tools and library for reading Outlook files (.pst format)"
HOMEPAGE="http://www.five-ten-sg.com/libpst/"
SRC_URI="http://www.five-ten-sg.com/${PN}/packages/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~x86"
IUSE="debug"

# newest version optionally pulls in boost for py bindings
RDEPEND="media-libs/gd[png]
	media-gfx/imagemagick[png]"
	#>=dev-libs/boost-1.35.0-r5[python]"
DEPEND="${RDEPEND}"

# we disable the python bindings for now. Feel free to fix the configure script to know about py 2.6 and 
# such advanced concepts ...
src_configure() {
	econf \
		$(use_enable debug pst-debug) \
		--enable-libpst-shared \
		--disable-python
}

src_compile() {
	emake CC=$(tc-getCC) || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS TODO || die "dodoc failed"
}
