# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/portagedb/portagedb-0.2.0.ebuild,v 1.5 2005/01/03 17:24:09 blubb Exp $

inherit flag-o-matic

DESCRIPTION="Small utility for searching ebuilds with indexing for fast results"
HOMEPAGE="http://sourceforge.net/projects/portdb"
SRC_URI="mirror://sourceforge/portdb/${PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug"

DEPEND="sys-devel/gcc
	virtual/libc
	sys-libs/libstdc++-v3"
RDEPEND="sys-apps/portage
	sys-libs/libstdc++-v3
	virtual/libc"

src_compile() {
	aclocal
	libtoolize --force --copy
	autoconf

	use debug && append-flags -g
	./configure --prefix=/usr || die "configure failed"

	emake || die "emake	failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
}

pkg_postinst() {
	einfo "Please run '/usr/bin/portagedb u' to setup the portage search database."
	einfo "The database file will be located at /var/cache/portagedb"
}
