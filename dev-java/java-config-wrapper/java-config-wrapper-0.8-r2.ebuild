# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/java-config-wrapper/java-config-wrapper-0.8-r2.ebuild,v 1.1 2006/06/25 00:28:16 nichoj Exp $

inherit eutils
DESCRIPTION="Wrapper for java-config"
HOMEPAGE="http://www.gentoo.org/proj/en/java"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
DEPEND="!<dev-java/java-config-1.3"

IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}
	# fix a typo
	epatch ${FILESDIR}/${P}-qfile.patch
}

src_install() {
	dobin src/shell/*
}
