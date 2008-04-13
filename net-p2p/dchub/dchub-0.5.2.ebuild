# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/dchub/dchub-0.5.2.ebuild,v 1.11 2008/04/13 21:48:15 betelgeuse Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="1.4"

inherit eutils autotools

IUSE=""

HOMEPAGE="http://ac2i.homelinux.com/dctc/#dchub"
DESCRIPTION="dchub (Direct Connect Hub), a linux hub for the p2p 'direct connect'"
SRC_URI="http://brainz.servebeer.com/dctc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc ppc64 x86 ~amd64"

RDEPEND="
	=dev-libs/glib-2*
	sys-devel/libperl
	dev-libs/libxml2
	dev-libs/libgcrypt
	sys-libs/zlib"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-amd64.patch"
}

src_install() {
	make DESTDIR="${D}" install || die "install problem"

	dodoc Documentation/*
	dodoc AUTHORS COPYING ChangeLog NEWS README TODO || die

	dodir /etc/dchub
	newinitd {FILESDIR}/dchub.init.d dchub
	newconfd ${FILESDIR}/dchub.conf.d dchub
}
