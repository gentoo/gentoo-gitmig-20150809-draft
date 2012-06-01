# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/xbase/xbase-2.0.0-r1.ebuild,v 1.2 2012/06/01 19:23:31 ago Exp $

EAPI="4"
inherit base eutils

DESCRIPTION="XBase is an xbase (i.e. dBase, FoxPro, etc.) compatible C++ class library"
HOMEPAGE="http://www.rekallrevealed.org/"
SRC_URI="http://www.rekallrevealed.org/packages/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="doc"

RDEPEND=""
DEPEND="${DEPEND}
	sys-devel/automake
	sys-devel/libtool"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc43.patch
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	base_src_install
	# media-tv/linuxtv-dvb-apps collision, bug #208596
	mv "${ED}/usr/bin/zap" "${ED}/usr/bin/xbase-zap" || die
	find "${D}" -name '*.la' -exec rm -f {} +

	dodoc AUTHORS ChangeLog NEWS README TODO
	if use doc; then
		dohtml html/*
		insinto /usr/share/doc/${PF}/examples
		doins examples/{*.cpp,examples.ide,makefile.g95}
	fi
}
