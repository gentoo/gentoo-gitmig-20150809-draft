# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/ufed/ufed-0.36.ebuild,v 1.5 2005/04/08 23:38:35 vapier Exp $

DESCRIPTION="Gentoo Linux USE flags editor"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://dev.gentoo.org/~truedfx/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 arm hppa ia64 m68k ~mips ppc ~ppc64 s390 sh ~sparc ~x86"
IUSE=""

RDEPEND="dev-lang/perl
	>=dev-util/dialog-1.0.20050206
	dev-perl/TermReadKey
	sys-apps/grep"

src_install() {
	newsbin ufed.pl ufed || die
	doman ufed.8
	dodoc ChangeLog
}
