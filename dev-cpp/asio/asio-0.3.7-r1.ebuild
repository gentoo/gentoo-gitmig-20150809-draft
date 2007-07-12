# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/asio/asio-0.3.7-r1.ebuild,v 1.1 2007/07/12 23:17:07 dev-zero Exp $

inherit eutils

KEYWORDS="~amd64 ~x86"

DESCRIPTION="asynchronous network library"
HOMEPAGE="http://asio.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="Boost-1.0"
SLOT="0"
IUSE="doc examples ssl"

DEPEND="ssl? ( dev-libs/openssl )
		>=dev-libs/boost-1.33.0"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-recursive_init.patch"
	epatch "${FILESDIR}/${P}-double_delete_fix.patch"

	# Don't build nor install any examples or unittests
	# since we don't have a script to run them
	cat > src/Makefile.in <<-EOF
all:

install:
	EOF
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc README THANKS TODO

	if use doc ; then
		dohtml -r doc/*
	fi
	if use examples ; then
		insinto /usr/share/doc/${PF}
		doins -r src/examples
	fi
}
