# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/cryptplug/cryptplug-0.3.15.ebuild,v 1.8 2004/01/08 02:25:23 avenj Exp $

DESCRIPTION="GPG and S/MIME encryption plugins.  Use by KMail v1.5 (KDE 3.1) and Mutt"
HOMEPAGE="http://www.gnupg.org/"
SRC_URI="ftp://ftp.gnupg.org/gcrypt/alpha/cryptplug/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~amd64"
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
