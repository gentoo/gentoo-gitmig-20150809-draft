# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dvmysql/dvmysql-0.4.11.ebuild,v 1.2 2006/11/23 20:15:08 vivo Exp $

inherit eutils

DESCRIPTION="dvmysql provides a C++ interface to mysql"
HOMEPAGE="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvmysql/html/"
SRC_URI="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvmysql/download/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

IUSE=""

DEPEND="virtual/libc
	virtual/mysql
	dev-libs/dvutil"

src_install() {
	make prefix=${D}/usr datadir=${D}/usr/share install
}
