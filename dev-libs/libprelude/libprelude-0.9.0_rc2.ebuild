# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libprelude/libprelude-0.9.0_rc2.ebuild,v 1.3 2005/04/06 17:08:58 vanquirius Exp $

inherit versionator

MY_P="${PN}-$(replace_version_separator 3 '-')"
DESCRIPTION="Prelude-IDS Framework Library"
HOMEPAGE="http://www.prelude-ids.org/"
SRC_URI="http://www.prelude-ids.org/download/releases/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~ia64 ~amd64"
IUSE="ssl"

DEPEND="virtual/libc
	ssl? ( dev-libs/openssl )
	>=net-libs/gnutls-1.0.17"

#	doc? ( dev-util/gtk-doc )"
# Doc disabled as per bug 77575

S="${WORKDIR}/${MY_P}"

src_compile() {
	local myconf

	use ssl && myconf="${myconf} --enable-openssl" || myconf="${myconf} --enable-openssl=no"
	# use doc && myconf="${myconf} --enable-gtk-doc" || myconf="${myconf} --enable-gtk-doc=no"

	econf ${myconf} || die "econf failed"
	emake -j1 || die "emake failed"
	# -j1 may not be necessary in the future
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
}
