# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/mono-debugger/mono-debugger-0.50.ebuild,v 1.2 2007/06/27 09:28:55 jurek Exp $

inherit eutils mono

DESCRIPTION="Debugger for .NET managed and unmanaged applications"
HOMEPAGE="http://www.go-mono.com"
SRC_URI="http://go-mono.com/sources/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

DEPEND=">=dev-lang/mono-1.2.4
		sys-libs/readline"

RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PN}-kernel-2.6.19-fix-i386-asm.patch || die
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc README ChangeLog AUTHORS NEWS
}
