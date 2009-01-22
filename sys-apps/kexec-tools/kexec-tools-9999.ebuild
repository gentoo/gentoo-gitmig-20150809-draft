# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/kexec-tools/kexec-tools-9999.ebuild,v 1.3 2009/01/22 13:40:38 darkside Exp $

EGIT_REPO_URI="git://git.kernel.org/pub/scm/linux/kernel/git/horms/kexec-tools.git"
inherit git autotools

DESCRIPTION="Load another kernel from the currently executing Linux kernel"
HOMEPAGE="http://www.kernel.org/pub/linux/kernel/people/horms/kexec-tools/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="zlib"

DEPEND="zlib? ( sys-libs/zlib )"

src_unpack() {
	git_src_unpack
	cd "${S}"
	eautoreconf
}

src_compile() {
	econf $(use_with zlib) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	doman kexec/kexec.8
	dodoc News AUTHORS TODO doc/*.txt

	newinitd "${FILESDIR}"/kexec.init kexec
	newconfd "${FILESDIR}"/kexec.conf kexec
}
