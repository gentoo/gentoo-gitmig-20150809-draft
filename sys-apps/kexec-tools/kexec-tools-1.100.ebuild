# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/kexec-tools/kexec-tools-1.100.ebuild,v 1.1 2005/01/31 16:19:13 genstef Exp $

DESCRIPTION="Load another kernel from the currently executing Linux kernel."
HOMEPAGE="http://www.xmission.com/~ebiederm/files/kexec/"
SRC_URI="http://www.xmission.com/~ebiederm/files/kexec/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

src_install() {
	into /
	dosbin ${S}/objdir/build/sbin/kexec

	exeinto /etc/init.d
	newexe ${FILESDIR}/kexec.init kexec

	insinto /etc/conf.d
	newins ${FILESDIR}/kexec.conf kexec

	doman kexec/kexec.8
	dodoc News AUTHORS TODO
}
