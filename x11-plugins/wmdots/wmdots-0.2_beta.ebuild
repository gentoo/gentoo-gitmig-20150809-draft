# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmdots/wmdots-0.2_beta.ebuild,v 1.13 2008/01/12 15:45:00 nixnut Exp $

inherit eutils multilib toolchain-funcs

DESCRIPTION="multishape 3d rotating dots"
HOMEPAGE="http://dockapps.org/file.php/id/116"
SRC_URI="http://dockapps.org/download.php/id/153/${P/_/}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-stringh.patch
	sed -e "s:cc:$(tc-getCC):g" \
		-e "s:-g -O2:${CFLAGS}:g" -i Makefile
}

src_compile() {
	emake clean || die "emake clean failed."
	emake LIBDIR="-L/usr/$(get_libdir)" || die "emake failed."
}

src_install() {
	dobin wmdots
}
