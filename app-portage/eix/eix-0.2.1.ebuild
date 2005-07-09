# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/eix/eix-0.2.1.ebuild,v 1.8 2005/07/09 02:38:36 swegener Exp $

inherit eutils flag-o-matic

DESCRIPTION="Small utility for searching ebuilds with indexing for fast results"
HOMEPAGE="http://eixwiki.unfoog.de"
SRC_URI="mirror://sourceforge/eix/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ~alpha ia64 ~ppc sparc"

DEPEND="sys-devel/gcc
	virtual/libc"
RDEPEND="sys-apps/portage
	virtual/libc"

src_compile() {
	aclocal
	libtoolize --force --copy
	autoconf

	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
}

pkg_postinst() {
	einfo "Please run '/usr/bin/eix -u' to setup the portage search database."
	einfo "The database file will be located at /var/cache/eix"
}
