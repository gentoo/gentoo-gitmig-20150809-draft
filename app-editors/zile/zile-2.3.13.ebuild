# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/zile/zile-2.3.13.ebuild,v 1.2 2009/11/30 10:21:20 maekke Exp $

EAPI=2

DESCRIPTION="Zile is a small Emacs clone"
HOMEPAGE="http://www.gnu.org/software/zile/"
SRC_URI="mirror://gnu/zile/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha amd64 ~ppc ~sparc x86 ~sparc-fbsd ~x86-fbsd"
IUSE="test valgrind"

RDEPEND="sys-libs/ncurses"
DEPEND="${RDEPEND}
	sys-apps/help2man
	test? ( valgrind? ( dev-util/valgrind ) )"

src_configure() {
	econf $(use test && use_with valgrind || echo "--without-valgrind")
}

src_install() {
	emake DESTDIR="${D}" install || die
	# FAQ is installed by the build system in /usr/share/zile
	dodoc AUTHORS BUGS NEWS README THANKS || die
}
