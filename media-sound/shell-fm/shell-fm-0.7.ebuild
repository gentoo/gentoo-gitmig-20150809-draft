# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/shell-fm/shell-fm-0.7.ebuild,v 1.2 2009/11/24 14:09:05 flameeyes Exp $

EAPI=2
inherit toolchain-funcs eutils

DESCRIPTION="A lightweight console based player for Last.FM radio streams"
HOMEPAGE="http://nex.scrapping.cc/shell-fm/"
# I couldn't get constant tarball from github so I've tarballed this myself.
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="media-libs/libmad
	media-libs/libao
	media-libs/taglib"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-apps/sed"

src_prepare() {
	epatch "${FILESDIR}/${P}-asneeded.patch"

	sed -i -e "s:-Os::" source/Makefile || die "sed failed"
}

src_compile() {
	tc-export CC
	emake || die "emake failed"
}

src_install() {
	dobin source/${PN} || die "dobin failed"
	doman manual/${PN}.1 || die
	exeinto /usr/share/${PN}/scripts
	doexe scripts/{*.sh,*.pl,zcontrol} || die "doexe failed"
}
