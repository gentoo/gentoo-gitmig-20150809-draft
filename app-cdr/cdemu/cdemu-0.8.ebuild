# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdemu/cdemu-0.8.ebuild,v 1.3 2007/01/14 15:35:42 vapier Exp $

inherit linux-mod python

DESCRIPTION="mount bin/cue cd images"
HOMEPAGE="http://cdemu.org/"
SRC_URI="mirror://sourceforge/cdemu/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc x86"
IUSE=""
RESTRICT="test" #158556

DEPEND="virtual/linux-sources"
RDEPEND="dev-lang/python"

MODULE_NAMES="cdemu(block:${S})"
BUILD_TARGETS="clean default"

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog README TODO
}

pkg_postinst() {
	python_mod_compile /usr/lib*/python*/site-packages/libcdemu.py
	linux-mod_pkg_postinst
}

pkg_postrm() {
	python_mod_cleanup
	linux-mod_pkg_postrm
}
