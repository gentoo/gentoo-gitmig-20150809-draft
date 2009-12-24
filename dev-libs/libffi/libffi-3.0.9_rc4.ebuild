# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libffi/libffi-3.0.9_rc4.ebuild,v 1.1 2009/12/24 10:05:32 ssuominen Exp $

inherit autotools eutils

DESCRIPTION="a portable, high level programming interface to various calling conventions."
HOMEPAGE="http://sourceware.org/libffi/"
SRC_URI="ftp://sources.redhat.com/pub/${PN}/${P/_}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="debug static-libs test"

RDEPEND=""
DEPEND="test? ( dev-util/dejagnu )"

S=${WORKDIR}/${P/_}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e '/ACLOCAL_AMFLAGS/d' Makefile.am || die
	epatch "${FILESDIR}"/${P}-revert_includedir.patch \
		"${FILESDIR}"/libffi-3.0.8-autoconf-2.64.patch
	eautoreconf
}

src_compile() {
	econf \
		--disable-dependency-tracking \
		$(use_enable static-libs static) \
		$(use_enable debug)
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog* README
}
