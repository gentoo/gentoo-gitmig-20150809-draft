# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/synergy/synergy-1.3.6.ebuild,v 1.3 2011/11/26 10:37:31 hwoarang Exp $

EAPI=3

inherit cmake-utils

DESCRIPTION="Lets you easily share a single mouse and keyboard between multiple computers."
HOMEPAGE="http://synergy-foss.org/"
SRC_URI="http://${PN}.googlecode.com/files/${P}-Source.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

RDEPEND="x11-libs/libXtst
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXinerama"
DEPEND="${RDEPEND}
	x11-proto/xextproto
	x11-proto/xproto
	x11-proto/kbproto
	x11-proto/xineramaproto
	x11-libs/libXt"

S=${WORKDIR}/${P}-Source

src_install () {
	dobin "${CMAKE_BUILD_DIR}"/${PN}{c,s} || die

	insinto /etc
	doins examples/synergy.conf || die

	mv doc/${PN}c.man  doc/${PN}c.1 || die
	mv doc/${PN}s.man  doc/${PN}s.1 || die
	doman doc/${PN}{c,s}.1 || die

	dodoc README || die
}
