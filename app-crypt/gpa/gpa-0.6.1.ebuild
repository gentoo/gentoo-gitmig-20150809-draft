# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gpa/gpa-0.6.1.ebuild,v 1.7 2004/02/07 02:30:05 pylon Exp $

DESCRIPTION="Standard GUI for GnuPG"
SRC_URI="ftp://ftp.gnupg.org/gcrypt/alpha/gpa/${P}.tar.gz"
HOMEPAGE="http://www.gnupg.org/(en)/related_software/gpa/index.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc"
IUSE="nls"

DEPEND=">=x11-libs/gtk+-2.0*
	>=app-crypt/gnupg-1.2*
	>=app-crypt/gpgme-0.4*
	nls? ( sys-devel/gettext )"


src_compile() {
	GPGME_CONFIG=/usr/bin/gpgme4-config econf `use_enable nls`

	emake || die
}

src_install() {
	einstall
	dodoc AUTHORS COPYING ChangeLog README NEWS TODO
}

