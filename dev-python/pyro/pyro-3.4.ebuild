# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyro/pyro-3.4.ebuild,v 1.4 2007/03/04 09:50:06 lucass Exp $

inherit distutils eutils

MY_P="Pyro-${PV}"
DESCRIPTION="advanced and powerful Distributed Object Technology system written entirely in Python"
HOMEPAGE="http://pyro.sourceforge.net/"
SRC_URI="mirror://sourceforge/pyro/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND="virtual/python"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-unattend.patch
}

src_install() {
	distutils_src_install

	dodir /usr/share/doc/${PF}/examples
	cp -r ${S}/examples ${D}/usr/share/doc/${PF}
	dohtml -r docs/*

	mv ${D}/usr/bin/esd ${D}/usr/bin/pyroesd
}

pkg_postinst() {
	elog "Pyro's Event Service Daemon, /usr/bin/esd has been renamed to"
	elog " /usr/bin/pyroesd to avoid conflict with media-sound/esound."
}
