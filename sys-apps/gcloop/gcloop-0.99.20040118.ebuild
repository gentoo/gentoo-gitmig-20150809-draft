# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gcloop/gcloop-0.99.20040118.ebuild,v 1.1 2004/01/23 22:43:40 lu_zero Exp $

DESCRIPTION="Compressed loopback userspace tools and kernel patches"

HOMEPAGE="http://www.gentoo.org/proj/en/releng/gcloop"

SRC_URI="http://dev.gentoo.org/~lu_zero/gcloop/${P}.tar.bz2"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"

IUSE=""

DEPEND="dev-libs/ucl"

S=${WORKDIR}/${PN}-0.99

src_compile() {
	make || die
}

src_install() {
	exeinto /usr/bin

	dobin compress_gcloop_ucl
	dobin compressloop_ucl
	dobin create_compressed_ucl_fs
	dobin create_gcloop_ucl
	dobin extract_compressed_ucl_fs
	dobin extract_gcloop_ucl

	doman ${S}/man/*.1

	dodir /usr/share/gcloop
	doins ${S}/*.patch

	dodoc CHANGELOG README README.kernel
}

pkg_postinst() {
	ewarn "This is a gcloop prerelease, userspace tool may change."
	ewarn "Please report any bug to lu_zero@gentoo.org via e-mail "
	ewarn "or bugzilla. "
	ewarn "REMEBER this is a PRERELEASE"
	echo
	einfo "the kernel patches are installed in /usr/share/gcloop ."
	einfo "ppc-development-sources and gentoo-dev-sources are"
	einfo "already patched."
}
