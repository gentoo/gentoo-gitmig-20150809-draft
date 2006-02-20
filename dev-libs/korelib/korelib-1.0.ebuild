# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/korelib/korelib-1.0.ebuild,v 1.10 2006/02/20 08:16:30 halcy0n Exp $

inherit eutils autotools

IUSE=""
DESCRIPTION="theKompany's cross-platform c++ library for developing modular applications"
SRC_URI="ftp://ftp.rygannon.com/pub/Korelib/${P}.tar.gz"
HOMEPAGE="http://www.thekompany.com/projects/korelib/"

DEPEND=""

LICENSE="GPL-2 QPL-1.0"
SLOT="1"
KEYWORDS="x86"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-gentoo.diff
	#this is really weird - lib developers did not run automake themselves
	#leaving this to the "end users"
	eautomake
}

src_compile() {
	./configure \
		--host=${CHOST} --prefix=/usr || die "configure failed"

	emake || die
}

src_install() {
	make DESTDIR="${D}" install

	#the lib installs one binary with by the name "demo" - bad choice
	mv "${D}"/usr/bin/demo "${D}"/usr/bin/kore-demo

	dodoc AUTHORS COPYING ChangeLog NEWS README THANKS TODO
}

