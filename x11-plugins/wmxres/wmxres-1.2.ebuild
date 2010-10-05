# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmxres/wmxres-1.2.ebuild,v 1.9 2010/10/05 20:29:16 voyageur Exp $

inherit eutils multilib toolchain-funcs

DESCRIPTION="Dock application to select your display mode among those possible"
HOMEPAGE="http://yalla.free.fr/wn"
SRC_URI="http://yalla.free.fr/wn/${PN}-1.1-0.tar.gz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="~amd64 x86 ~ppc"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm
	x11-libs/libXxf86vm"
DEPEND="${RDEPEND}
	x11-libs/libXxf86dga
	x11-proto/xextproto
	x11-proto/xf86vidmodeproto"

S=${WORKDIR}/${PN}.app

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-debian-1.1-1.2.patch
	sed -e "s:-g -c -O2:${CFLAGS} -c:" \
		-e "s:cc:$(tc-getCC) \$(LDFLAGS):g" -i Makefile
}

src_compile() {
	emake INCDIR="-I/usr/include" \
		LIBDIR="-L/usr/$(get_libdir)" || die "emake failed."
}

src_install() {
	dobin ${PN}/${PN}
	doman ${PN}.1
}
