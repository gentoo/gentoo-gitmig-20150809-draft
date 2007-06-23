# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/dvipdfmx/dvipdfmx-20050831.ebuild,v 1.6 2007/06/23 19:17:48 armin76 Exp $

inherit eutils

IUSE=""

DESCRIPTION="DVI to PDF translator with multi-byte character support"
HOMEPAGE="http://project.ktug.or.kr/dvipdfmx/"
SRC_URI="http://project.ktug.or.kr/dvipdfmx/snapshot/current/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc sparc x86"

RDEPEND="virtual/tetex
	virtual/ghostscript
	>=media-libs/libpng-1.2.1
	>=sys-libs/zlib-1.1.4
	>=dev-libs/openssl-0.9.6i"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

has_tetex_3() {
	if has_version '>=app-text/tetex-3' || has_version '>=app-text/ptex-3.1.8' ; then
		true
	else
		false
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e 's/\(f dvipdfm.map\)/%\1/' \
		-e '/^%% GhostScript (Unix\/Linux)/,+1s/^%//g' \
		data/config/dvipdfmx.cfg || die
}

src_install() {
	# the default directory hierarchy doesn't match our scheme
	#make DESTDIR=${D} install || die

	dobin src/dvipdfmx || die

	insinto /usr/share/texmf/dvipdfm
	doins data/config/glyphlist.txt || die

	insinto /usr/share/texmf/dvipdfm/config
	doins data/config/dvipdfmx.cfg || die

	insinto /usr/share/texmf/fonts/map/dvipdfm
	doins ${FILESDIR}/cid-x.map || die

	insinto /usr/share/texmf/fonts/cmap
	doins data/CMap/*-UCS2*

	dosym /usr/share/ghostscript/Resource /usr/share/texmf/fonts/cmap/ghostscript
	dosym /opt/Acroread5/Resource /usr/share/texmf/fonts/cmap/Acroread5
	dosym /opt/Acroread7/Resource /usr/share/texmf/fonts/cmap/Acroread7
	dosym /usr/share/xpdf /usr/share/texmf/fonts/cmap/xpdf

	dodoc BUGS ChangeLog FONTMAP README TODO
}

pkg_postinst() {
	has_tetex_3 && texmf-update || mktexlsr
}

pkg_postrm() {
	has_tetex_3 && texmf-update || mktexlsr
}
