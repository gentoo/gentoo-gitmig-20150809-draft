# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/camserv/camserv-0.5.1-r2.ebuild,v 1.13 2009/11/26 10:22:09 maekke Exp $

WANT_AUTOCONF=2.5
WANT_AUTOMAKE=1.6

inherit autotools eutils

DESCRIPTION="A streaming video server"
HOMEPAGE="http://cserv.sourceforge.net"
SRC_URI="mirror://sourceforge/cserv/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND="media-libs/jpeg
	media-libs/imlib2"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P/.1}-errno.patch
	epatch "${FILESDIR}"/${P}-libtool.patch
	epatch "${FILESDIR}"/${P}-memcpy.patch
	AT_M4DIR="${S}/macros" eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS BUGS ChangeLog NEWS README TODO javascript.txt
	newinitd "${FILESDIR}"/camserv.init camserv
}
