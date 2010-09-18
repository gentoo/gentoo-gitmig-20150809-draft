# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/dmake/dmake-4.11.ebuild,v 1.1 2010/09/18 03:38:38 jer Exp $

EAPI="2"

inherit toolchain-funcs

DESCRIPTION="Improved make"
HOMEPAGE="http://tools.openoffice.org/dmake/"
SRC_URI="http://tools.openoffice.org/${PN}/${P/-/_}.zip"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

DEPEND="sys-apps/groff"
RDEPEND=""

S=${WORKDIR}/${PN}

src_prepare() {
	sed -i unix/linux/gnu/make.sh \
		-e "s/gcc/$(tc-getCC) ${CFLAGS}/g" \
		-e "s|-O\( -o dmake\)|${LDFLAGS}\1|g" \
		|| die "sed failed"
}

src_compile() {
	sh unix/linux/gnu/make.sh || die "sh unix/linux/gnu/make.sh failed"
}

src_install () {
	dobin dmake || die "dobin failed"
	newman man/dmake.tf dmake.1 || die "newman failed"

	insinto /usr/share/dmake/startup
	doins -r startup/{{startup,config}.mk,unix} || die "doins failed"
}
