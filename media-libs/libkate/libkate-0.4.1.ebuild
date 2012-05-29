# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libkate/libkate-0.4.1.ebuild,v 1.3 2012/05/29 14:47:48 aballier Exp $

DESCRIPTION="Codec for karaoke and text encapsulation for Ogg"
HOMEPAGE="http://code.google.com/p/libkate/"
SRC_URI="http://libkate.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE="debug doc wxwidgets"

COMMON_DEPEND="media-libs/libogg
	media-libs/libpng"
DEPEND="${COMMON_DEPEND}
	wxwidgets? ( dev-lang/python )
	virtual/pkgconfig
	sys-devel/flex
	sys-devel/bison
	doc? ( app-doc/doxygen )"
RDEPEND="${COMMON_DEPEND}
	wxwidgets? ( =dev-python/wxpython-2.8* media-libs/liboggz )"

src_compile() {
	use wxwidgets || sed -i -e "s/HAVE_PYTHON=yes/HAVE_PYTHON=no/" configure
	econf $(use_enable debug) $(use_enable doc) --docdir=/usr/share/doc/${PF}
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README
}
