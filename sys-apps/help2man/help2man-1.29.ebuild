# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/help2man/help2man-1.29.ebuild,v 1.24 2004/11/12 15:12:12 vapier Exp $

DESCRIPTION="GNU utility to convert program --help output to a man page"
HOMEPAGE="http://www.gnu.org/software/help2man"
SRC_URI="http://ftp.gnu.org/gnu/help2man/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 ppc-macos sparc x86"
IUSE=""

DEPEND=""
RDEPEND="dev-lang/perl"

src_install(){
	dobin help2man || die
}
