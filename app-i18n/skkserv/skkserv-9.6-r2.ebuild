# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/skkserv/skkserv-9.6-r2.ebuild,v 1.2 2003/08/01 16:32:40 usata Exp $

S="${WORKDIR}/skk-${PV}mu"
MY_P="skk${PV}mu"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~alpha"
DESCRIPTION="Dictionary server for the SKK Japanese-input software"
SRC_URI="http://openlab.ring.gr.jp/skk/maintrunk/museum/${MY_P}.tar.gz"
HOMEPAGE="http://openlab.ring.gr.jp/skk/"
IUSE=""
DEPEND="virtual/glibc
        >=app-i18n/skk-jisyo-200210"

PROVIDE="virtual/skkserv"

src_unpack(){
	unpack ${A}
	cd ${S}/skkserv
	epatch ${FILESDIR}/${P}-segfault-gentoo.patch
}

src_compile() {
	econf --libexecdir=/usr/sbin || die "econf failed"
	cd skkserv

	emake || die
}

src_install () {

	cd skkserv
	dosbin skkserv

	# install rc script
	exeinto /etc/init.d ; newexe ${FILESDIR}/skkserv.initd skkserv
}
