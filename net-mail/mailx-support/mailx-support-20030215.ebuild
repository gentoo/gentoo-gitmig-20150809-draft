# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mailx-support/mailx-support-20030215.ebuild,v 1.1 2003/06/09 19:01:08 raker Exp $

DESCRIPTION="Provides mail.local and lockspool"
HOMEPAGE="http://www.openbsd.org/"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
DEPEND=""
RDEPEND=""
S=${WORKDIR}/${P}

src_unpack() {
	ebegin "Copying source files"
	(cp -R ${FILESDIR}/${P} ${WORKDIR} || (eend $?; die $? "Could not copy source files")) && eend 0
	cd ${S} || die "${S} does not exist"
	patch -p0 < ${FILESDIR}/${P}-gentoo.patch
}

src_compile() {
	emake || die
}

src_install() {
	einstall
}
