# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/shell-fm/shell-fm-0.6.ebuild,v 1.1 2009/05/09 11:38:51 ssuominen Exp $

EAPI=2
inherit toolchain-funcs

MY_P=jkramer-${PN}-7a4ba409f8776903d6dc54acd12ccd0d242592f8

DESCRIPTION="A lightweight console based player for Last.FM radio streams"
HOMEPAGE="http://nex.scrapping.cc/shell-fm/"
SRC_URI="http://github.com/jkramer/shell-fm/tarball/v${PV}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="ao"

RDEPEND="media-libs/libmad
	ao? ( media-libs/libao )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}

src_prepare() {
	sed -i -e "s:-Os:${CFLAGS}:g" source/Makefile || die "sed failed"
	use ao || sed -i -e "s:\$(LIBAO)::g" source/Makefile || die "sed failed"
}

src_compile() {
	tc-export CC
	emake || die "emake failed"
}

src_install() {
	dobin source/${PN} || die "dobin failed"
	doman manual/${PN}.1
	exeinto /usr/share/${PN}/scripts
	doexe scripts/{*.sh,*.pl,zcontrol} || die "doexe failed"
}
