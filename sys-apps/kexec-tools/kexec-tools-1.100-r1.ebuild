# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/kexec-tools/kexec-tools-1.100-r1.ebuild,v 1.1 2005/02/04 21:15:32 genstef Exp $

DESCRIPTION="Load another kernel from the currently executing Linux kernel"
HOMEPAGE="http://www.xmission.com/~ebiederm/files/kexec/"
SRC_URI="http://www.xmission.com/~ebiederm/files/kexec/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

src_install() {
	into /
	dosbin objdir*/build/sbin/kexec || die "dosbin failed"
	doman kexec/kexec.8
	dodoc News AUTHORS TODO

	newinitd ${FILESDIR}/kexec.init kexec
	newconfd ${FILESDIR}/kexec.conf kexec
}
