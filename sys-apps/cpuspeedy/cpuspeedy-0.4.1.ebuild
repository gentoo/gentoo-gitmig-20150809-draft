# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/cpuspeedy/cpuspeedy-0.4.1.ebuild,v 1.1 2004/07/28 06:27:13 dragonheart Exp $

inherit python

DESCRIPTION="A simple and easy to use program to control the speed and the voltage of CPUs on the fly."
SRC_URI="mirror://sourceforge/cpuspeedy/${P}.tar.gz"
HOMEPAGE="http://cpuspeedy.sourceforge.net/"
KEYWORDS="~x86 ~ppc"
SLOT="0"
LICENSE="GPL-2"
IUSE=""
RESTRICT="nomirror"
DEPEND=">=sys-apps/sed-4"
RDEPEND="virtual/python"

src_compile() {
	einfo "There is nothing to compile."
}

src_install() {
	make install PREFIX=${D}/usr || die "make install failed"
	sed -i -e "s:${D}::" ${D}/usr/sbin/cpuspeedy
	mv ${D}/usr/share/doc/cpuspeedy ${D}/usr/share/doc/${PF}
}

pkg_postinst() {
	python_mod_optimize /usr/lib/cpuspeedy
}

pkg_postrm() {
	python_mod_cleanup /usr/lib/cpuspeedy
}

