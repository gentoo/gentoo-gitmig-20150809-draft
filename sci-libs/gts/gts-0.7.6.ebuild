# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/gts/gts-0.7.6.ebuild,v 1.2 2006/09/02 20:19:33 dberkholz Exp $

DESCRIPTION="GNU Triangulated Surface Library"
LICENSE="LGPL-2"
HOMEPAGE="http://gts.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"

DEPEND=">=dev-libs/glib-2.4.0
		sys-apps/gawk
		sys-devel/libtool
		dev-util/pkgconfig"

src_compile() {
	econf || die "Configure failed"
	emake || die "Make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO

	# fix up examples
	sed -e "s:/var/tmp/portage/gts-0.7.6/work/gts-0.7.6/:/usr/share/gts/:g" \
		-e "s:../src/.libs/libgts.so:/usr/lib/libgts.so:g" \
		-i examples/* || \
		die "Failed to fix-up example scripts"

	# install examples
	insinto /usr/share/${PN}/examples
	doins examples/* || die "Failed to install examples"

	# install additional docs
	if use doc; then
		dohtml doc/html/*
	fi
}

