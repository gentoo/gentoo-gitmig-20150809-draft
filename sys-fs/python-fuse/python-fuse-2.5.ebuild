# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/python-fuse/python-fuse-2.5.ebuild,v 1.2 2007/09/30 15:28:02 swegener Exp $

inherit distutils

MY_P="${PN}_${PV}"

KEYWORDS="~amd64 ~x86"
DESCRIPTION="Python FUSE bindings"
HOMEPAGE="http://fuse.sourceforge.net/wiki/index.php/FusePython"
SRC_URI="http://ftp.debian.org/debian/pool/main/p/${PN}/${MY_P}.orig.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

PROVIDE="virtual/fuse-python"

RDEPEND=">=dev-lang/python-2.3
		>=sys-fs/fuse-2.0"

src_compile() {
	distutils_src_compile
}

src_install() {
	distutils_src_install
	cp -r example ${D}/usr/share/doc/${PF}/
}
