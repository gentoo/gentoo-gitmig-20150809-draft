# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/zniper/zniper-1.0-r1.ebuild,v 1.1 2010/09/17 03:53:49 jer Exp $

EAPI="2"

inherit toolchain-funcs

DESCRIPTION="Displays and kill active TCP connections seen by the selected interface."
HOMEPAGE="http://www.signedness.org/tools/"
SRC_URI="http://www.signedness.org/tools/zniper.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="net-libs/libpcap
	sys-libs/ncurses"
RDEPEND="${DEPEND}"

S=${WORKDIR}/"zniper"

src_prepare() {
	sed -i Makefile \
		-e 's| -o | $(LDFLAGS)&|g' \
		-e 's|@make|@$(MAKE)|g' \
		|| die "sed Makefile"
}

src_compile() {
	emake \
		CC=$(tc-getCC) \
		CFLAGS="${CFLAGS}" \
		linux_x86 \
		|| die "emake failed"
}

src_install() {
	dobin zniper
	dodoc README
	doman zniper.1
}
