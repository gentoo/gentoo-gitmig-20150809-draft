# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/ldns/ldns-1.6.6.ebuild,v 1.1 2010/08/11 00:15:33 matsuu Exp $

EAPI="3"
PYTHON_DEPEND="python? 2:2.4"

inherit multilib python

DESCRIPTION="ldns is a library with the aim to simplify DNS programing in C"
HOMEPAGE="http://www.nlnetlabs.nl/projects/ldns/"
SRC_URI="http://www.nlnetlabs.nl/downloads/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc-macos ~x64-macos"
IUSE="doc python ssl vim-syntax"

RDEPEND="ssl? ( >=dev-libs/openssl-0.9.7 )"
DEPEND="${RDEPEND}
	python? ( dev-lang/swig )
	doc? ( app-doc/doxygen )"

pkg_setup() {
	python_set_active_version 2
}

src_configure() {
	econf \
		$(use_enable ssl sha2) \
		$(use_with ssl) \
		$(use_with python pyldns) \
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

	if use python ; then
		rm "${ED}/usr/$(get_libdir)"/python*/site-packages/_ldns.*a || die
	fi

	if use doc ; then
		dohtml doc/html/* || die "dohtml failed"
	fi

	if use vim-syntax ; then
		insinto /usr/share/vim/vimfiles/ftdetect
		doins libdns.vim || die "doins libdns.vim failed"
	fi
}
