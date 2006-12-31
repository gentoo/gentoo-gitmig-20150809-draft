# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/javatoolkit/javatoolkit-0.2.0-r1.ebuild,v 1.1 2006/12/31 19:21:27 betelgeuse Exp $

inherit eutils python

DESCRIPTION="Collection of Gentoo-specific tools for Java"
HOMEPAGE="http://www.gentoo.org/proj/en/java/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

DEPEND="virtual/python"
RDEPEND="virtual/python"

IUSE=""

src_unpack() {
	unpack "${A}"
	cd "${S}"
	epatch "${FILESDIR}/0.2.0-use-sax.patch"
	# Fix version
	sed -i -e s/${PV}/${PVR}/ makedefs.mak
}

src_install() {
	make DESTDIR=${D} install || die
}

pkg_postinst() {
	python_mod_optimize /usr/share/javatoolkit
}

pkg_postrm() {
	python_mod_cleanup /usr/share/javatoolkit
}
