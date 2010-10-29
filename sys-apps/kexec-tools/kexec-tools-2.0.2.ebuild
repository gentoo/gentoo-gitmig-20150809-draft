# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/kexec-tools/kexec-tools-2.0.2.ebuild,v 1.1 2010/10/29 17:14:29 radhermit Exp $

EAPI=2

inherit eutils flag-o-matic

DESCRIPTION="Load another kernel from the currently executing Linux kernel"
HOMEPAGE="http://kernel.org/pub/linux/utils/kernel/kexec/"
SRC_URI="mirror://kernel/linux/utils/kernel/kexec/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="lzma xen zlib"

DEPEND="zlib? ( sys-libs/zlib )
	lzma? ( app-arch/xz-utils )"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${PN}-2.0.0-respect-LDFLAGS.patch"

	# to disable the -fPIE -pie in the hardened compiler
	if gcc-specs-pie ; then
		filter-flags -fPIE
		append-ldflags -nopie
	fi
}

src_configure() {
	econf $(use_with lzma) $(use_with xen) $(use_with zlib)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	doman kexec/kexec.8 || die "doman failed"
	dodoc News AUTHORS TODO || die "dodoc failed"

	newinitd "${FILESDIR}"/kexec.init kexec || die
	newconfd "${FILESDIR}"/kexec.conf kexec || die
}
