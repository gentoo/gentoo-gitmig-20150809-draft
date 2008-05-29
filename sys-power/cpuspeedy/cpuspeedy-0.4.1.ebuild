# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/cpuspeedy/cpuspeedy-0.4.1.ebuild,v 1.3 2008/05/29 18:11:15 hawking Exp $

inherit python multilib

DESCRIPTION="A simple and easy to use program to control the speed and the voltage of CPUs on the fly."
SRC_URI="mirror://sourceforge/cpuspeedy/${P}.tar.gz"
HOMEPAGE="http://cpuspeedy.sourceforge.net/"
KEYWORDS="~amd64 ppc x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""
RDEPEND="virtual/python"

src_compile() {
	einfo "There is nothing to compile."
}

src_install() {
	emake install PREFIX="${D}"/usr || die "make install failed"
	sed -i -e "s:${D}::" "${D}"/usr/sbin/cpuspeedy
	mv "${D}"/usr/share/doc/cpuspeedy "${D}"/usr/share/doc/${PF}
	dodir /usr/share
	mv "${D}"/usr/man "${D}"/usr/share
}

pkg_postinst() {
	python_mod_optimize /usr/$(get_libdir)/${PN}
}

pkg_postrm() {
	python_mod_cleanup /usr/$(get_libdir)/${PN}
}
