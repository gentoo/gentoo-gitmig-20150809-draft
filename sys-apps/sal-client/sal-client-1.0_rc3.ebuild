# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/sal-client/sal-client-1.0_rc3.ebuild,v 1.1 2003/06/08 18:06:20 zhen Exp $

MY_P=${P/_/-}

DESCRIPTION="Server side programs for SAL, the Secure Auditing for Linux project."
HOMEPAGE="http://secureaudit.sourceforge.net/"

SRC_URI="http://belnet.dl.sourceforge.net/sourceforge/secureaudit/${MY_P/rc3/RC3}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="-x86"
IUSE=""

DEPEND="virtual/glibc \
		>=dev-libs/openssl-0.9.6j"

RDEPEND="${DEPEND} \
		>=sys-kernel/hardened-sources-2.4.20-r2"

S=${WORKDIR}/sal-client

src_compile() {
	emake || die
	#make || die
}

src_install() {
	dosbin ${S}/daemon/auditd
	dosbin ${S}/client/auditclient


	exeinto /etc/init.d; newexe ${FILESDIR}/sal-client-init auditd
	insinto /etc/conf.d; newins ${FILESDIR}/auditd.confd auditd 

	mv ${S}/patches/README ${S}/patches/README.patches
	mv ${S}/patches/README.todo ${S}/patches/README.todo.patches
	dodoc ${S}/README
	dodoc ${S}/README.todo
	dodoc ${S}/patches/README.patches
	dodoc ${S}/patches/README.todo.patches

}
