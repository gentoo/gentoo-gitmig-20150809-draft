# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libgpg-error/libgpg-error-0.6.ebuild,v 1.2 2004/02/02 03:12:07 avenj Exp $

DESCRIPTION="Contains error handling functions used by GnuPG"
HOMEPAGE="http://www.gnupg.org/"
SRC_URI="ftp://ftp.gnupg.org/gcrypt/alpha/${PN}/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="nls"

DEPEND="virtual/glibc"
RDEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	econf $(use_enable nls) || die
	emake || die
}

src_install() {
	einstall || die
	dodoc ABOUT-NLS AUTHORS ChangeLog NEWS README
}
