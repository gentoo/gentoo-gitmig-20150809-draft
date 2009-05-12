# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/asio/asio-1.4.1.ebuild,v 1.1 2009/05/12 08:34:26 ssuominen Exp $

EAPI=2

DESCRIPTION="Asynchronous Network Library"
HOMEPAGE="http://asio.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="Boost-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples ssl test"

RDEPEND="ssl? ( dev-libs/openssl )
	>=dev-libs/boost-1.34.1"
DEPEND="${DEPEND}"

src_prepare() {
	if ! use test; then
		# Don't build nor install any examples or unittests
		# since we don't have a script to run them
		cat > src/Makefile.in <<-EOF
all:

install:
		EOF
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README

	if use doc ; then
		dohtml -r doc/*
	fi

	if use examples; then
		if use test; then
			# Get rid of the object files
			emake clean || die "emake clean failed"
		fi
		insinto /usr/share/doc/${PF}
		doins -r src/examples
	fi
}
