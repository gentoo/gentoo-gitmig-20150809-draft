# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/lsat/lsat-0.9.6.ebuild,v 1.1 2007/05/25 10:59:23 matsuu Exp $

inherit eutils toolchain-funcs

DESCRIPTION="The Linux Security Auditing Tool"
HOMEPAGE="http://usat.sourceforge.net/"
SRC_URI="http://usat.sourceforge.net/code/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="minimal"

DEPEND="dev-lang/perl" # pod2man
RDEPEND="!minimal? (
		app-portage/portage-utils
		net-analyzer/nmap
		sys-apps/iproute2
		sys-apps/which
		sys-process/lsof
	)"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gentoo.patch
}

src_compile() {
	tc-export CC
	econf || die
	emake CFLAGS="${CFLAGS}" all manpage || die
}

src_install() {
	emake DESTDIR="${D}" install installman || die
	dodoc README* *.txt
	dohtml modules.html changelog/changelog.html
}
