# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/sakura/sakura-2.4.1.ebuild,v 1.2 2011/09/20 03:58:07 radhermit Exp $

EAPI=4
inherit cmake-utils

DESCRIPTION="sakura is a terminal emulator based on GTK and VTE"
HOMEPAGE="http://www.pleyades.net/david/projects/sakura/"
SRC_URI="http://www.pleyades.net/david/projects/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
LANGS=" ca cs de es fr hr hu it ja ko pl pt_BR ru zh_CN"
IUSE="${LANGS// / linguas_}"

RDEPEND="
	>=dev-libs/glib-2.20
	>=x11-libs/gtk+-2.16:2
	>=x11-libs/vte-0.26:0
"
DEPEND="${RDEPEND}
	>=dev-lang/perl-5.10.1
	dev-util/pkgconfig
"

DOCS=( AUTHORS INSTALL )

src_prepare() {
	for lang in ${LANGS}; do
		if ! use linguas_${lang}; then
			rm -f po/${lang}.po || die
		fi
	done
}

src_install() {
	cmake-utils_src_install
	rm -rf "${D}"/usr/share/doc/${PN}
}
