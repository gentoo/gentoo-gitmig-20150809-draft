# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libprelude/libprelude-0.8.10.ebuild,v 1.10 2005/01/25 08:48:45 dragonheart Exp $

DESCRIPTION="Prelude-IDS Framework Library"
HOMEPAGE="http://www.prelude-ids.org/"
SRC_URI="http://www.prelude-ids.org/download/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha ia64 amd64"
IUSE="ssl"

DEPEND="virtual/libc
	ssl? ( dev-libs/openssl )"

#	doc? ( dev-util/gtk-doc )"
# Doc disabled as per bug 77575

src_compile() {
	local myconf

	use ssl && myconf="${myconf} --enable-openssl" || myconf="${myconf} --enable-openssl=no"
	# use doc && myconf="${myconf} --enable-gtk-doc" || myconf="${myconf} --enable-gtk-doc=no"

	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
}
