# Copyright 2001-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Damon Conway <damon@3jane.net> 
# $Header: /var/cvsroot/gentoo-x86/net-mail/nmh/nmh-1.0.4.ebuild,v 1.4 2002/05/23 06:50:16 seemant Exp $


S=${WORKDIR}/${P}
DESCRIPTION="New MH mail reader"
SRC_URI="ftp://ftp.mhost.com/pub/nmh/${P}.tar.gz"
HOMEPAGE="http://www.mhost.com/nmh/"

DEPEND="virtual/glibc"

src_compile() {
	# Redifining libdir to be bindir so the support binaries get installed
	# correctly.  Since no libraries are installed with nmh, this does not
	# pose a problem at this time.

	econf \
		--enable-nmh-pop \
		--sysconfdir=/etc/nmh \
		--libdir=/usr/bin || die

	make || die
}

src_install() {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		libdir=${D}/usr/bin \
		etcdir=${D}/etc/nmh \
		install || die

	dodoc COMPLETION-TCSH COMPLETION-ZSH TODO FAQ DIFFERENCES \
		MAIL.FILTERING Changelog*
}
