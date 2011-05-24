# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/shell-fm/shell-fm-0.8.ebuild,v 1.1 2011/05/24 21:12:43 radhermit Exp $

EAPI=4
inherit flag-o-matic toolchain-funcs eutils

DESCRIPTION="A lightweight console based player for Last.FM radio streams"
HOMEPAGE="http://nex.scrapping.cc/shell-fm/"
SRC_URI="https://github.com/jkramer/${PN}/tarball/v${PV} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux"
IUSE=""

RDEPEND="media-libs/libmad
	media-libs/libao
	media-libs/taglib"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-apps/sed"

src_unpack() {
	unpack ${A}
	mv *-${PN}-* "${S}"
}

src_prepare() {
	sed -i -e "s:-Os::" source/Makefile || die "sed failed"

	tc-export CC AR
	if use ppc; then
		append-flags -DWORDS_BIGENDIAN=1
	fi
}

src_install() {
	dobin source/${PN}
	doman manual/${PN}.1
	exeinto /usr/share/${PN}/scripts
	doexe scripts/{*.sh,*.pl,zcontrol}
}
