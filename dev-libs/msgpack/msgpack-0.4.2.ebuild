# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/msgpack/msgpack-0.4.2.ebuild,v 1.2 2011/05/10 10:55:37 naota Exp $

EAPI="2"
inherit autotools eutils

DESCRIPTION="MessagePack is a binary-based efficient data interchange format"
HOMEPAGE="http://msgpack.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/${PN}/46155/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE="test"

DEPEND="test? ( dev-util/gtest )"
RDEPEND=""

src_prepare() {
	epatch "${FILESDIR}/${P}-test.patch"
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog NEWS README || die
}
