# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/bunny/bunny-0.92.ebuild,v 1.3 2008/11/24 16:52:31 ssuominen Exp $

inherit toolchain-funcs

DESCRIPTION="A small general purpose fuzzer for C programs."
HOMEPAGE="http://code.google.com/p/bunny-the-fuzzer"
SRC_URI="http://bunny-the-fuzzer.googlecode.com/files/${P}.tgz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/openssl"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" \
		|| die "emake failed."
}

src_test() {
	emake test1 || die "emake test1 failed."
	emake test2 || die "emake test2 failed."
	emake test3 || die "emake test3 failed."
}

src_install() {
	dobin ${PN}-{exec,flow,gcc,main,trace} || die "dobin failed."
	dodoc CHANGES README
}
