# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/skkserv/skkserv-9.6.ebuild,v 1.4 2002/12/15 10:44:11 bjb Exp $

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

src_compile() {
	./configure \
	       --host=${CHOST} \
	       --prefix=/usr \
		   --libexecdir=/usr/sbin || die "./configure failed"
	cd skkserv

	emake || die
}

src_install () {

	cd skkserv
	dosbin skkserv

	# install rc script and its config file
	exeinto /etc/init.d ; newexe ${FILESDIR}/${PF}/skkserv.initd skkserv
}
