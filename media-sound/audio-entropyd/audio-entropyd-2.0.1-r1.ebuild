# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/audio-entropyd/audio-entropyd-2.0.1-r1.ebuild,v 1.5 2012/05/13 10:45:27 swift Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Audio-entropyd generates entropy-data for the /dev/random device."
HOMEPAGE="http://www.vanheusden.com/aed/"
SRC_URI="http://www.vanheusden.com/aed/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE="selinux"

RDEPEND="selinux? ( sec-policy/selinux-entropyd )
	media-sound/alsa-utils"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-uclibc.patch" \
		"${FILESDIR}/${P}-ldflags.patch"
	sed -i -e "s:^OPT_FLAGS=.*:OPT_FLAGS=${CFLAGS}:" Makefile
}

src_compile() {
	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	dosbin audio-entropyd || die "dosbin failed"
	dodoc README TODO
	newinitd "${FILESDIR}/${PN}.init-2" ${PN}
	newconfd "${FILESDIR}/${PN}.conf-2" ${PN}
}
