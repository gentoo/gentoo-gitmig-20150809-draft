# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/man-pages-de/man-pages-de-0.4.ebuild,v 1.1 2005/09/02 04:28:32 vapier Exp $

DESCRIPTION="A somewhat comprehensive collection of Linux german man page translations"
HOMEPAGE="http://www.infodrom.org/projects/manpages-de/"
SRC_URI="http://www.infodrom.org/projects/manpages-de/download/manpages-de-${PV}.tar.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE=""

RDEPEND="sys-apps/man"

S=${WORKDIR}/manpages-de-${PV}

src_compile() { :; }

src_install() {
	make MANDIR="${D}"/usr/share/man/de install  || die
	dodoc CHANGES README
}
