# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/man-pages-de/man-pages-de-0.4.ebuild,v 1.5 2006/03/28 05:54:47 vapier Exp $

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

	# Remove man pages provided by other packages
	#  - shadow
	rm "${D}"/usr/share/man/de/man1/{chsh,groups,login,passwd,newgrp}.1*
	#  - man
	rm "${D}"/usr/share/man/de/man1/{apropos,man,whatis}.1*
}
