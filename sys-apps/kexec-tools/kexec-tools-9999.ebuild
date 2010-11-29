# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/kexec-tools/kexec-tools-9999.ebuild,v 1.6 2010/11/29 20:42:14 radhermit Exp $

EAPI=2

EGIT_REPO_URI="git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git"
inherit git autotools

DESCRIPTION="Load another kernel from the currently executing Linux kernel"
HOMEPAGE="http://kernel.org/pub/linux/utils/kernel/kexec/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="xen zlib"
DEPEND="zlib? ( sys-libs/zlib )"
RDEPEND="${DEPEND}"

src_unpack() {
	git_src_unpack
	cd "${S}"
	eautoreconf
}

src_configure() {
	econf $(use_with zlib) $(use_with xen)
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	doman kexec/kexec.8
	dodoc News AUTHORS TODO doc/*.txt

	newinitd "${FILESDIR}"/kexec.init kexec || die
	newconfd "${FILESDIR}"/kexec.conf kexec || die
}
