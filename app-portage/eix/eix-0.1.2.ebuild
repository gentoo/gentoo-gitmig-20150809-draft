# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/eix/eix-0.1.2.ebuild,v 1.2 2005/01/18 17:02:08 hollow Exp $

inherit flag-o-matic

DESCRIPTION="Small utility for searching ebuilds with indexing for fast results"
HOMEPAGE="http://sourceforge.net/projects/eix"
SRC_URI="mirror://sourceforge/eix/${PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="sys-devel/gcc
		virtual/libc"
RDEPEND="sys-apps/portage
		virtual/libc"

src_compile() {
	aclocal
	libtoolize --force --copy
	autoconf

	econf || die "econf failed"
	emake || die "emake	failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
}

pkg_postinst() {
	einfo "Please run '/usr/bin/eix u' to setup the portage search database."
	einfo "The database file will be located at /var/cache/eix"
}
