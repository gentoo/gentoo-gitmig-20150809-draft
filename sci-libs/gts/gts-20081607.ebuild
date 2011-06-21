# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/gts/gts-20081607.ebuild,v 1.4 2011/06/21 08:25:15 jlec Exp $

EAPI="1"

inherit eutils fortran-2

DESCRIPTION="GNU Triangulated Surface Library"
LICENSE="LGPL-2"
HOMEPAGE="http://gts.sourceforge.net/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"

RDEPEND="
	dev-libs/glib:2
	sys-apps/gawk
	media-libs/netpbm"
DEPEND="${RDEPEND}
		sys-devel/libtool
		dev-util/pkgconfig"

S="${WORKDIR}"/${PN}-snapshot-080704

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-0.7.6-include-fix.patch
}

src_install() {
	make DESTDIR="${D}" install || die "Install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO

	# install examples
	insinto /usr/share/${PN}/examples
	doins examples/*.c || die "Failed to install examples"

	# install additional docs
	if use doc; then
		dohtml doc/html/*
	fi
}
