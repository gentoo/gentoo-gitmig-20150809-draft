# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/dnotify/dnotify-0.16.0.ebuild,v 1.1 2004/07/17 23:28:07 dragonheart Exp $

DESCRIPTION="Execute a command when the contents of a directory change"
SRC_URI="http://www.student.lu.se/~nbi98oli/src/${P}.tar.gz"
HOMEPAGE="http://www.student.lu.se/~nbi98oli/"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~mips"
IUSE="nls"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/libc
	sys-apps/gawk
	sys-apps/grep
	sys-devel/gettext"

RDEPEND="virtual/libc"

src_compile() {
	econf `use_enable nls` || die "failed to configure"
	emake || die "failed to make"
}

src_install() {
	emake DESTDIR=${D} \
		install || die
	dodoc AUTHORS INSTALL TODO ChangeLog COPYING* NEWS README
}

src_test() {
	make check
}
