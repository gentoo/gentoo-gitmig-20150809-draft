# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/ufed/ufed-0.36.ebuild,v 1.4 2005/04/08 20:06:46 pylon Exp $

DESCRIPTION="Gentoo Linux USE flags editor"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://dev.gentoo.org/~truedfx/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ppc ~sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64 ~ppc64"
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
