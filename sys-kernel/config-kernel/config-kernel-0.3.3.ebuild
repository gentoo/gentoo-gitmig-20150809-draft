# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/config-kernel/config-kernel-0.3.3.ebuild,v 1.1 2004/04/03 16:35:12 latexer Exp $

inherit distutils

S=${WORKDIR}/${P}
DESCRIPTION="Kernel enviroment configuration tool"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="http://dev.gentoo.org/~latexer/files/koutput/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
DEPEND=">=sys-apps/sed-4"
RDEPEND="virtual/python"
KEYWORDS="x86"
IUSE=""

src_unpack() {
	unpack ${A}

	sed -i -e 's:^KBUILD_OUTPUT_PREFIX=.*:KBUILD_OUTPUT_PREFIX="":' ${S}/05kernel
}

src_install() {
	distutils_src_install
	dobin ${S}/config-kernel
	doman ${S}/config-kernel.1
	dodoc ChangeLog

	if [ ! -e /etc/env.d/05kernel ]
	then
		insinto /etc/env.d
		doins 05kernel
	fi
}
