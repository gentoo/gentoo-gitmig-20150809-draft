# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/ufed/ufed-0.35-r2.ebuild,v 1.4 2004/12/08 13:08:48 dragonheart Exp $

inherit eutils

DESCRIPTION="Gentoo Linux USE flags editor"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc mips ~alpha arm hppa amd64 ia64 ppc64"
IUSE=""

RDEPEND="dev-lang/perl
	>=dev-util/dialog-1.0.20040731
	dev-perl/TermReadKey"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/*.patch
}

src_install() {
	newsbin ufed.pl ufed || die
	doman ufed.8
	dodoc ChangeLog
}
