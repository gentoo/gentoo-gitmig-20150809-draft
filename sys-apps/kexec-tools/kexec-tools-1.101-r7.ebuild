# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/kexec-tools/kexec-tools-1.101-r7.ebuild,v 1.1 2009/01/22 13:59:21 darkside Exp $

inherit eutils

DESCRIPTION="Load another kernel from the currently executing Linux kernel"
HOMEPAGE="http://www.xmission.com/~ebiederm/files/kexec/"
SRC_URI="http://www.xmission.com/~ebiederm/files/kexec/${P}.tar.gz
	http://lse.sourceforge.net/kdump/patches/1.101-kdump10/kexec-tools-1.101-kdump10.patch"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="zlib"
DEPEND="zlib? ( sys-libs/zlib )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${DISTDIR}"/kexec-tools-1.101-kdump10.patch
	epatch "${FILESDIR}"/${P}-LDFLAGS.patch
	epatch "${FILESDIR}"/${P}-ppc64.patch
	epatch "${FILESDIR}"/kexec-linux-headers.patch
	epatch "${FILESDIR}"/${P}-respect-LDFLAGS.patch
}

src_compile() {
	econf $(use_with zlib) || die "econf failed"
	sed -i -e 's/=-Wall/+=-Wall/' Makefile.conf || die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	doman kexec/kexec.8
	dodoc News AUTHORS TODO

	newinitd "${FILESDIR}"/kexec.init kexec
	newconfd "${FILESDIR}"/kexec.conf kexec
}
