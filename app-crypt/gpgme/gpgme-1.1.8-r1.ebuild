# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gpgme/gpgme-1.1.8-r1.ebuild,v 1.6 2009/04/30 12:52:30 jer Exp $

EAPI=2
inherit libtool eutils

DESCRIPTION="GnuPG Made Easy is a library for making GnuPG easier to use"
HOMEPAGE="http://www.gnupg.org/related_software/gpgme"
SRC_URI="mirror://gnupg/gpgme/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2"
SLOT="1"
KEYWORDS="~alpha amd64 hppa ~ia64 ~mips ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE="pth"

DEPEND=">=dev-libs/libgpg-error-1.4
	app-crypt/gnupg
	pth? ( >=dev-libs/pth-1.2 )"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-et_EE.patch
	# We need to call elibtoolize so that we get sane .so versioning on
	# fbsd.
	elibtoolize
}

src_configure() {
	econf \
		--includedir=/usr/include/gpgme \
		--with-gpg=/usr/bin/gpg \
		--with-gpgsm=/usr/bin/gpgsm \
		$(use_with pth)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
}
