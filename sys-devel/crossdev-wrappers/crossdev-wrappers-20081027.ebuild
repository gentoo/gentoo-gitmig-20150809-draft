# Copyright 2008-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/crossdev-wrappers/crossdev-wrappers-20081027.ebuild,v 1.1 2008/10/27 04:20:48 solar Exp $

inherit toolchain-funcs eutils

DESCRIPTION="emerge wrappers for crossdev"
HOMEPAGE="http://embedded.gentoo.org"
SRC_URI="mirror://gentoo/${P}.tar.bz2 http://dev.gentoo.org/~solar/embedded/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE=""

DEPEND=""

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"
}

src_compile() {
	make PREFIX=/usr || die
}

src_install() {
	make PREFIX=/usr DESTDIR="${D}" install
}

pkg_postinst() {
	einfo "Running emerge-wrapper --init"
	emerge-wrapper --init
}
