# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/kexec-tools/kexec-tools-1.101-r1.ebuild,v 1.3 2006/02/25 07:52:23 vapier Exp $

inherit eutils

DESCRIPTION="Load another kernel from the currently executing Linux kernel"
HOMEPAGE="http://www.xmission.com/~ebiederm/files/kexec/"
SRC_URI="http://www.xmission.com/~ebiederm/files/kexec/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-LDFLAGS.patch
	epatch "${FILESDIR}"/${P}-ppc64.patch
}

src_install() {
	into /
	dosbin objdir*/build/sbin/kexec || die "dosbin failed"
	doman kexec/kexec.8
	dodoc News AUTHORS TODO

	newinitd "${FILESDIR}"/kexec.init kexec
	newconfd "${FILESDIR}"/kexec.conf kexec
}
