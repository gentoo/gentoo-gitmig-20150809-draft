# Copyright 2002 Arcady Genkin <agenkin@thpoon.com>
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Arcady Genkin <agenkin@thpoon.com>
# $Header: /var/cvsroot/gentoo-x86/net-mail/grepmail/grepmail-4.70.ebuild,v 1.2 2002/05/27 17:27:39 drobbins Exp $

DESCRIPTION="Search normal or compressed mailbox using a regular expression or dates."
HOMEPAGE="http://grepmail.sourceforge.net/"

SRC_URI="mirror://sourceforge/grepmail/${P}.tar.gz"
S=${WORKDIR}/${P}

DEPEND="dev-perl/TimeDate
        dev-perl/DateManip"

src_compile () {
    perl Makefile.PL FASTREADER=0 PREFIX=/usr
    emake || die
}

src_install () {
    # BUG: Can't quite work out the compilation of the FastReader module.
    # For now it's disabled.
    make PREFIX=${D}/usr \
         INSTALLMAN1DIR=${D}/usr/share/man/man1 \
         INSTALLMAN3DIR=${D}/usr/share/man/man3 \
         install || die
    dodoc MANIFEST LICENSE CHANGES README
}
