# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mailx-support/mailx-support-20030215.ebuild,v 1.9 2004/04/27 20:58:05 agriffis Exp $

inherit eutils

DESCRIPTION="Provides mail.local and lockspool"
HOMEPAGE="http://www.openbsd.org/"
LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~ppc sparc ~alpha ~mips hppa ia64 ~amd64"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch
}

src_compile() {
	emake
}

src_install() {
	einstall
}
