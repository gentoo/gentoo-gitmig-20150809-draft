# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/quota/quota-3.06-r1.ebuild,v 1.1 2002/12/10 17:49:41 styx Exp $

S=${WORKDIR}/quota-tools
DESCRIPTION="Linux quota tools"
SRC_URI="mirror://sourceforge/linuxquota/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/linuxquota/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc "

DEPEND="virtual/glibc"

src_compile() {
	econf || die "./configure failed"
	emake || die
}

src_install() {
	dodir {sbin,etc,usr/sbin,usr/bin,usr/share/man/man{1,2,3,8}}
	make ROOTDIR=${D} install || die
#	install -m 644 warnquota.conf ${D}/etc
	insinto /etc
	insopts -m0644
	doins warnquota.conf quotatab
	dodoc doc/*

	exeinto /etc/init.d
	newexe ${FILESDIR}/quota.rc quota
}
