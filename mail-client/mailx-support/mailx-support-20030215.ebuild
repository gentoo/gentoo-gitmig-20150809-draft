# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/mailx-support/mailx-support-20030215.ebuild,v 1.5 2004/07/14 16:17:56 agriffis Exp $

inherit eutils

DESCRIPTION="Provides mail.local and lockspool"
HOMEPAGE="http://www.openbsd.org/"
LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha ~mips hppa ia64 amd64"
IUSE=""
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
