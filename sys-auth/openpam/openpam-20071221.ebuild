# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/openpam/openpam-20071221.ebuild,v 1.2 2008/06/09 07:01:38 aballier Exp $

inherit multilib flag-o-matic autotools

DESCRIPTION="Open source PAM library."
HOMEPAGE="http://www.openpam.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86-fbsd"
IUSE="debug vim-syntax"

RDEPEND="!virtual/pam"
DEPEND="sys-devel/make
	dev-lang/perl"
PDEPEND="sys-auth/pambase
	vim-syntax? ( app-vim/pam-syntax )"

PROVIDE="virtual/pam"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-gentoo.patch"
	epatch "${FILESDIR}/${PN}-20050201-nbsd.patch"
	epatch "${FILESDIR}/${PN}-20050616-redef.patch"
	epatch "${FILESDIR}/${PN}-20050616-optional.patch"

	sed -i -e 's:-Werror::' "${S}/configure.ac"

	eautoreconf
	elibtoolize
}

src_compile() {
	econf \
		--disable-dependency-tracking \
		--with-modules-dir=/$(get_libdir)/security/ \
		${myconf} || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake -j1 DESTDIR="${D}" install

	dodoc CREDITS HISTORY MANIFEST RELNOTES README
}
