# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/cryptplug/cryptplug-0.3.15.ebuild,v 1.7 2004/01/04 15:23:22 weeve Exp $

DESCRIPTION="GPG and S/MIME encryption plugins.  Use by KMail v1.5 (KDE 3.1) and Mutt"
HOMEPAGE="http://www.gnupg.org/"
SRC_URI="ftp://ftp.gnupg.org/gcrypt/alpha/cryptplug/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc"
IUSE=""
DEPEND="=app-crypt/gpgme-0.3.14"
S=${WORKDIR}/${P}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die
}
