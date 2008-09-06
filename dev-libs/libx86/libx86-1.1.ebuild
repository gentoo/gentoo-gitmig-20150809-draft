# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libx86/libx86-1.1.ebuild,v 1.1 2008/09/06 13:03:19 gentoofan23 Exp $

inherit multilib

DESCRIPTION="A hardware-independent library for executing real-mode x86 code"
HOMEPAGE="http://www.codon.org.uk/~mjg59/libx86"
SRC_URI="http://www.codon.org.uk/~mjg59/${PN}/downloads/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_compile() {
	local ARGS
	if use amd64; then
		ARGS="BACKEND=x86emu"
	fi
	emake ${ARGS} || die
}

src_install() {
	emake LIBDIR="/usr/$(get_libdir)" DESTDIR="${D}" install || die
}
