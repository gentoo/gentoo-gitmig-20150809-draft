# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libaio/libaio-0.3.15-r1.ebuild,v 1.6 2009/02/09 19:07:54 armin76 Exp $

inherit eutils multilib

MY_PV=${PV}-2.5-2
MY_P=${PN}-${MY_PV}

DESCRIPTION="Asynchronous input/output library that uses the kernels native interface"
HOMEPAGE="http://www.kernel.org/pub/linux/kernel/people/andrea/libaio/"
SRC_URI="http://www.kernel.org/pub/linux/kernel/people/andrea/libaio/${MY_P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 arm -hppa ia64 ~m68k mips ~ppc s390 sh sparc ~x86"
IUSE=""

DEPEND=""

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-CFLAGS.patch
	epatch "${FILESDIR}"/${P}-more-arches.patch
	epatch "${FILESDIR}"/${P}-no-exec-stack.patch
	sed -i -e "s:/lib/:/$(get_libdir)/:g" src/Makefile
}

src_install() {
	make prefix="${D}"/usr install || die
	dodoc ChangeLog TODO
}
