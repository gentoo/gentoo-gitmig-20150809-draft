# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/wayv/wayv-0.2.ebuild,v 1.1 2003/02/17 00:26:42 zhen Exp $

PKG=${P/-0.2/.0.2}
MY_P=${P/-0.2}

DESCRIPTION="Wayv is hand-writing/gesturing recognition software for X"
HOMEPAGE="http://www.stressbunny.com/wayv"
SRC_URI="http://cvs.gentoo.org/~zhen/${PKG}.tar.gz"
LICENSE="GPL2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/x11 virtual/glibc"
RDEPEND=""

S=${WORKDIR}/${MY_P}

src_compile() {
	
	econf || die
	emake || die
}

src_install() {

	einstall || die
}
