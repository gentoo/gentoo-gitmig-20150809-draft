# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/takcd/takcd-0.10.ebuild,v 1.8 2005/05/09 13:22:28 agriffis Exp $

IUSE=""

DESCRIPTION="Command line CD player"
HOMEPAGE="http://bard.sytes.net/takcd/"
SRC_URI="http://bard.sytes.net/takcd/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha amd64 ~hppa ia64 ~mips ~ppc sparc x86"

RDEPEND="virtual/libc"

DEPEND="sys-devel/autoconf
	sys-devel/automake"

src_compile() {
	export WANT_AUTOMAKE=1.4
	export WANT_AUTOCONF=2.1
	./autogen.sh
	emake || die
}

src_install() {
	einstall || die

	dodoc AUTHORS ChangeLog NEWS README* TODO
}
