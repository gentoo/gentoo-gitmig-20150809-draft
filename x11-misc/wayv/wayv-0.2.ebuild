# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/wayv/wayv-0.2.ebuild,v 1.7 2005/05/08 20:11:45 wormo Exp $

PKG=${P/-0.2/.0.2}
MY_P=${P/-0.2}

DESCRIPTION="Wayv is hand-writing/gesturing recognition software for X"
HOMEPAGE="http://www.stressbunny.com/wayv"
SRC_URI="http://cvs.gentoo.org/~zhen/${PKG}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/x11 virtual/libc"
RDEPEND=""

S=${WORKDIR}/${MY_P}

src_compile() {

	econf || die
	emake || die
}

src_install() {

	einstall || die
}
