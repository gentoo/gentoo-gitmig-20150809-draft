# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/man-pages-da/man-pages-da-0.1.1.ebuild,v 1.3 2010/10/19 09:16:25 leio Exp $

DESCRIPTION="A somewhat comprehensive collection of Danish Linux man pages"
HOMEPAGE="http://www.sslug.dk/locale/man-sider/"
SRC_URI="http://www.sslug.dk/locale/man-sider/manpages-da-${PV}.tar.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86"
IUSE=""

RDEPEND="virtual/man"

S=${WORKDIR}/manpages-da-${PV}

src_compile() { :; }

src_install() {
	dodir /usr/share/man
	make install-data PREFIX="${D}"/usr/share || die
	dodoc AUTHORS ChangeLog
}
