# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libjingle/libjingle-0.3.12.ebuild,v 1.5 2009/05/08 01:28:47 loki_val Exp $

inherit autotools eutils

DESCRIPTION="Google's jabber voice extension library modified by Tapioca/Farsight"
HOMEPAGE="http://farsight.freedesktop.org/"
SRC_URI="http://farsight.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~sparc ~x86"
IUSE=""

RDEPEND="dev-libs/openssl
	dev-libs/expat"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# See bug #238262
	epatch "${FILESDIR}/${P}-asneeded.patch"

	# See bug 267816
	epatch "${FILESDIR}/${P}-gcc44.patch"

	eautomake
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README
}
