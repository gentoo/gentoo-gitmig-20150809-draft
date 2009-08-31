# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/evilvte/evilvte-0.4.5_pre7.ebuild,v 1.1 2009/08/31 16:12:58 ssuominen Exp $

EAPI=2
inherit toolchain-funcs savedconfig versionator

MY_P=${PN}-$(replace_version_separator 3 '~')

DESCRIPTION="VTE based, super lightweight terminal emulator"
HOMEPAGE="http://www.calno.com/evilvte"
SRC_URI="http://www.calno.com/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/vte
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	x11-libs/libXtst
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}

src_prepare() {
	if use savedconfig; then
		restore_config src/config.h
	fi
}

src_configure() {
	./configure --prefix=/usr || die
}

src_compile() {
	emake CC="$(tc-getCC)" OPTFLAGS="${CFLAGS}" || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc Changelog
	save_config src/config.h
}
