# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/gflags/gflags-1.7.ebuild,v 1.1 2012/02/16 18:51:51 nelchael Exp $

EAPI="3"

DESCRIPTION="Google's C++ argument parsing library."
HOMEPAGE="http://code.google.com/p/gflags/"
SRC_URI="http://gflags.googlecode.com/files/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="static-libs"

DEPEND=""
RDEPEND=""

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	rm -rf "${D}"/usr/share/doc/*
	dodoc AUTHORS ChangeLog NEWS README
	dohtml doc/*
}
