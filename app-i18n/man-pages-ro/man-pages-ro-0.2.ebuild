# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/man-pages-ro/man-pages-ro-0.2.ebuild,v 1.1 2005/09/02 04:26:48 vapier Exp $

DESCRIPTION="A somewhat comprehensive collection of Romanian Linux man pages"
HOMEPAGE="http://www.rolix.org/man/arhiva/"
SRC_URI="http://www.rolix.org/man/arhiva/${P}.tar.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE=""

RDEPEND="sys-apps/man"

S=${WORKDIR}/man-ro

src_compile() { :; }

src_install() {
	insinto /usr/share/man/ro/man1
	doins man1/*.1 || die "doins"
}
