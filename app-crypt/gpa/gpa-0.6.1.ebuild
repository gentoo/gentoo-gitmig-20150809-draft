# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gpa/gpa-0.6.1.ebuild,v 1.11 2004/09/10 01:44:53 dragonheart Exp $

DESCRIPTION="Standard GUI for GnuPG"
HOMEPAGE="http://www.gnupg.org/(en)/related_software/gpa/index.html"
SRC_URI="ftp://ftp.gnupg.org/gcrypt/alpha/gpa/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE="nls"

DEPEND=">=x11-libs/gtk+-2.0*
	>=app-crypt/gnupg-1.2*
	=app-crypt/gpgme-0.4*
	nls? ( sys-devel/gettext )"

src_compile() {
	GPGME_CONFIG=/usr/bin/gpgme4-config econf `use_enable nls` || die "econf failed"
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog README NEWS TODO
}
