# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/chkrootkit/chkrootkit-0.43-r4.ebuild,v 1.6 2004/10/17 11:37:22 absinthe Exp $

inherit eutils

DESCRIPTION="a tool to locally check for signs of a rootkit"
HOMEPAGE="http://www.chkrootkit.org/"
SRC_URI="ftp://ftp.pangeia.com.br/pub/seg/pac/${P}.tar.gz
		 mirror://gentoo/${P}-r3-gentoo.diff.gz"

LICENSE="AMS"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha ~ia64 amd64"
IUSE=""

DEPEND="virtual/libc
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/${P}-r3-gentoo.diff
	sed -i 's:${head} -:${head} -n :' chkrootkit
	sed -i 's:/var/adm:/var/log:g' chklastlog.c
}

src_compile() {
	make sense || die
}

src_install() {
	dosbin chkdirs chklastlog chkproc chkrootkit chkwtmp ifpromisc \
		strings-static || die
	dodoc README README.chklastlog README.chkwtmp

	exeinto /etc/cron.weekly
	doexe ${FILESDIR}/chkrootkit.cron
}

pkg_postinst() {
	echo
	einfo "Edit chkrootkit.cron in /etc/cron.weekly"
	einfo "to activate chkrootkit!"
	echo
}
