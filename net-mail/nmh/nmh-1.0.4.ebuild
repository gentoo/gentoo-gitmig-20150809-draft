# Copyright 2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Damon Conway <damon@3jane.net> 
# $Header: /var/cvsroot/gentoo-x86/net-mail/nmh/nmh-1.0.4.ebuild,v 1.2 2001/08/30 17:31:35 pm Exp $


A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="New MH mail reader"
SRC_URI="ftp://ftp.mhost.com/pub/nmh/${A}"
HOMEPAGE="http://www.mhost.com/nmh/"

DEPEND="virtual/glibc"


src_compile() {
	# Redifining libdir to be bindir so the support binaries get installed
	# correctly.  Since no libraries are installed with nmh, this does not
	# pose a problem at this time.
    try ./configure --prefix=/usr --mandir=/usr/share/man \
        --enable-nmh-pop --sysconfdir=/etc/nmh --libdir=/usr/bin
    try make
}

src_install() {
    try make prefix=${D}/usr mandir=${D}/usr/share/man \
		libdir=${D}/usr/bin etcdir=${D}/etc/nmh install

    dodoc COMPLETION-TCSH COMPLETION-ZSH TODO FAQ DIFFERENCES \
        MAIL.FILTERING Changelog*

    gzip -v ${D}/usr/share/man/man?/*.?
}

