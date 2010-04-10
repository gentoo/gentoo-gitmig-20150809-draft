# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libunistring/libunistring-0.9.1.1.ebuild,v 1.1 2010/04/10 17:34:52 chiiph Exp $

EAPI="2"

DESCRIPTION="Library for manipulating Unicode strings and C strings according to the Unicode standard"
HOMEPAGE="http://www.gnu.org/software/libunistring/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="LGPL-3 GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	if use doc; then
		emake -C doc info html || die "Build doc failed"
	fi

	emake || die "Build failed"
}

src_install() {
	dodoc AUTHORS README ChangeLog
	if use doc; then
		dohtml doc/libunistring.html
		doinfo doc/libunistring.info
	fi

	emake DESTDIR="${D}" install || die "Install failed"
}
