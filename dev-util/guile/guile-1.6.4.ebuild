# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/guile/guile-1.6.4.ebuild,v 1.1 2003/04/28 01:19:01 liquidx Exp $

DESCRIPTION="Scheme interpreter"
SRC_URI="mirror://gnu/guile/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/guile/"

IUSE=""
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND=">=sys-libs/ncurses-5.1
	>=sys-libs/readline-4.1"

# NOTE: in README-PACKAGERS, guile recommends different versions be installed
#       in parallel. They're talking about LIBRARY MAJOR versions and not
#       the actual guile version that was used in the past.
#     
#       So I'm slotting this as 12 beacuse of the library major version

SLOT="12"

src_compile() {
	econf \
		--with-threads \
		--with-modules || die
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog GUILE-VERSION HACKING NEWS README SNAPSHOTS THANKS
}
