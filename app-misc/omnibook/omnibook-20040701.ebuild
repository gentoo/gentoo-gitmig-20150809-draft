# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/omnibook/omnibook-20040701.ebuild,v 1.3 2004/10/26 13:26:22 vapier Exp $

inherit toolchain-funcs

MY_PV="2004-07-01"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Linux kernel module for HP Omnibook support"
HOMEPAGE="http://www.sourceforge.net/projects/omke"
SRC_URI="mirror://sourceforge/omke/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="${KV}"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/kernel"
S="${WORKDIR}/${MY_P}"

src_compile() {
	unset ARCH
	emake CC="$(tc-getCC) ${CFLAGS}" KSRC='/usr/src/linux' KERNEL="$(echo ${KV} | cut -c 1-3)" || die
}

src_install() {
	# The driver goes into the standard modules location
	# Not the make install location, because that way it would get deleted
	# when the user did a make modules_install in the Kernel tree

	insinto /lib/modules/${KV}/char
	doins omnibook.o || die

	dodoc ${S}/doc/*
}
