# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/xbsql/xbsql-0.11.ebuild,v 1.10 2012/06/30 17:15:51 jlec Exp $

inherit base

DESCRIPTION="An SQL Wrapper for the XBase library"
HOMEPAGE="http://www.rekallrevealed.org/"
SRC_URI="http://www.rekallrevealed.org/packages/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc x86"
IUSE="doc"

RDEPEND="~dev-db/xbase-2.0.0
	sys-libs/readline"
DEPEND="${RDEPEND}
	sys-devel/automake
	sys-devel/libtool"

src_install() {
	base_src_install
	dodoc AUTHORS Announce ChangeLog INSTALL README TODO
	use doc && dohtml doc/*
}
