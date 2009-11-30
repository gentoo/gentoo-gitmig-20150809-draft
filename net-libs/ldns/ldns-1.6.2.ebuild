# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/ldns/ldns-1.6.2.ebuild,v 1.2 2009/11/30 14:17:31 tove Exp $

EAPI="2"

DESCRIPTION="ldns is a library with the aim to simplify DNS programing in C"
HOMEPAGE="http://www.nlnetlabs.nl/projects/ldns/"
SRC_URI="http://www.nlnetlabs.nl/downloads/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc ssl vim-syntax"

RDEPEND="ssl? ( >=dev-libs/openssl-0.9.7 )"
DEPEND="${DEPEND}
	doc? ( app-doc/doxygen )"

src_configure() {
	econf \
		$(use_enable ssl sha2) \
		$(use_with ssl) \
		--disable-rpath || die "econf failed"
}

src_compile() {
	emake || die "emake failed"
	if use doc ; then
		emake doxygen || die "emake doxygen failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc Changelog README* || die "dodoc failed"

	if use doc ; then
		dohtml doc/html/* || die "dohtml failed"
	fi

	if use vim-syntax ; then
		insinto /usr/share/vim/vimfiles/ftdetect
		doins libdns.vim || die "doins libdns.vim failed"
	fi
}
