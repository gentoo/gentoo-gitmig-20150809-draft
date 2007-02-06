# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/openpam/openpam-20050616-r1.ebuild,v 1.1 2007/02/06 15:05:19 uberlord Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

inherit multilib flag-o-matic autotools

DESCRIPTION="Open source PAM library."
HOMEPAGE="http://www.openpam.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~sparc-fbsd ~x86-fbsd"
IUSE="debug vim-syntax"

RDEPEND="!virtual/pam"
DEPEND="sys-devel/make
	dev-lang/perl"
PDEPEND="|| ( sys-freebsd/freebsd-pam-modules sys-netbsd/netbsd-pam-modules )
	vim-syntax? ( app-vim/pam-syntax )"

PROVIDE="virtual/pam"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${PN}-20050201-gentoo.patch"
	epatch "${FILESDIR}/${PN}-20050201-nbsd.patch"
	epatch "${FILESDIR}/${P}-redef.patch"
	epatch "${FILESDIR}/${P}-optional.patch"

	sed -i -e 's:-Werror::' "${S}/configure.ac"

	eautoreconf
	elibtoolize
}

src_compile() {
	econf \
		--disable-dependency-tracking \
		--with-modules-dir=/$(get_libdir)/security \
		${myconf} || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake -j1 DESTDIR="${D}" install

	dodoc CREDITS HISTORY MANIFEST RELNOTES README
}
