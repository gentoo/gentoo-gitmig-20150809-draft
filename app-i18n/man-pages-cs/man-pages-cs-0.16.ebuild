# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/man-pages-cs/man-pages-cs-0.16.ebuild,v 1.1 2005/09/02 04:28:24 vapier Exp $

DESCRIPTION="A somewhat comprehensive collection of Linux czech man page translations"
HOMEPAGE="http://www.win.tue.nl/~aeb/linux/man/"
SRC_URI="ftp://ftp.win.tue.nl/pub/linux-local/manpages/translations/${P}.tar.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE=""

RDEPEND="sys-apps/man"

src_compile() { :; }

src_install() {
	make MANDIR="${D}"/usr/share/man/cs install || die
	dodoc CONTRIB README*
}
