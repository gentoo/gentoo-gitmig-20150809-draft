# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/ufed/ufed-0.2.ebuild,v 1.6 2003/03/11 21:11:44 seemant Exp $

DESCRIPTION="Gentoo Linux USE flags editor"
HOMEPAGE="http://www.gentoo.org"
SRC_URI="http://cvs.gentoo.org/~blizzy/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc hppa arm"
IUSE=""

RDEPEND="dev-lang/perl
	dev-util/dialog
	dev-perl/TermReadKey"
DEPEND=""

S="${WORKDIR}/${P}"

src_install() {
	newsbin ufed.pl ufed
}
