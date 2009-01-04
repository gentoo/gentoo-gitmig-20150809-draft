# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/audio-entropyd/audio-entropyd-1.0.5.ebuild,v 1.1 2009/01/04 13:24:59 angelos Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Audio-entropyd generates entropy-data for the /dev/random device."
HOMEPAGE="http://www.vanheusden.com/aed/"
SRC_URI="http://www.vanheusden.com/aed/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="selinux"

RDEPEND="selinux? ( sec-policy/selinux-audio-entropyd )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-uclibc.patch"
	sed -i -e "s:^OPT_FLAGS=.*:OPT_FLAGS=${CFLAGS}:" Makefile
}

src_compile() {
	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	dosbin audio-entropyd || die "dosbin failed"
	dodoc README README.2 TODO
	newinitd "${FILESDIR}/${PN}.init" ${PN}
	newconfd "${FILESDIR}/${PN}.conf" ${PN}
}
