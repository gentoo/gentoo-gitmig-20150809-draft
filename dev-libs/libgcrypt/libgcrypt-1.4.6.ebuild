# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libgcrypt/libgcrypt-1.4.6.ebuild,v 1.7 2010/09/30 20:18:25 ranger Exp $

EAPI="2"

inherit autotools eutils flag-o-matic toolchain-funcs

DESCRIPTION="General purpose crypto library based on the code used in GnuPG"
HOMEPAGE="http://www.gnupg.org/"
SRC_URI="mirror://gnupg/libgcrypt/${P}.tar.bz2
	ftp://ftp.gnupg.org/gcrypt/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm ~hppa ia64 m68k ~mips ~ppc ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-libs/libgpg-error-1.5"
DEPEND="${RDEPEND}"

src_prepare() {
	# Fix build failure with non-bash /bin/sh.
	eautoreconf

	epunt_cxx
}

src_configure() {
	# --disable-padlock-support for bug #201917
	econf \
		--disable-padlock-support \
		--disable-dependency-tracking \
		--with-pic \
		--enable-noexecstack
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README* THANKS TODO
}
