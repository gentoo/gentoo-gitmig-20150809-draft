# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/libpaper/libpaper-1.1.14.8.ebuild,v 1.2 2006/05/08 19:21:03 flameeyes Exp $

inherit versionator libtool eutils

MY_P="libpaper_$(replace_version_separator 3 ubuntu)"
DESCRIPTION="Library for handling paper characteristics"
HOMEPAGE="http://packages.ubuntulinux.org/dapper/source/libpaper"
SRC_URI="http://archive.ubuntu.com/ubuntu/pool/main/libp/libpaper/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE=""

S=${WORKDIR}/${MY_P/_/-}

src_unpack() {
	unpack ${A}
	cd ${S}
	ln -s /usr/share/libtool/config.sub
	ln -s /usr/share/libtool/config.guess

	epatch "${FILESDIR}/${P}-malloc.patch"

	elibtoolize
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	dodoc README ChangeLog
}
