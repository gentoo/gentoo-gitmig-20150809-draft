# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: System Team <system@gentoo.org>
# Author: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-editors/xemacs/xemacs-21.1.14.ebuild,v 1.6 2001/10/24 16:02:03 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="XEmacs"
EFS=1.26
BASE=1.55
DEPEND="X? virtual/x11"
SRC_URI="ftp://ftp.xemacs.org/pub/current/${P}.tar.bz2 ftp://ftp.xemacs.org/xemacs/packages/efs-${EFS}-pkg.tar.gz ftp://ftp.xemacs.org/xemacs/packages/xemacs-base-${BASE}-pkg.tar.gz"
HOMEPAGE="http://www.xemacs.org"

src_unpack() {
	cd ${WORKDIR}
	unpack ${P}.tar.bz2			
}

src_compile() {                           
	local myopts
	myopts="--without-x"
	use X && myopts="--with-x"
	./configure $myopts --prefix=/usr || die
	make || die
}

src_install() {                               
	make prefix=${D}/usr mandir=${D}/usr/share/man/man1 infodir=${D}/usr/share/info install || die
	# Install the two packages
	dodir /usr/lib/xemacs/xemacs-packages/
	cd ${D}/usr/lib/xemacs/xemacs-packages/
	unpack efs-${EFS}-pkg.tar.gz
	unpack xemacs-base-${BASE}-pkg.tar.gz
	#remove extraneous files
	cd ${D}/usr/share/info
	rm -f dir info.info texinfo* termcap*
	cd ${S}
	dodoc BUGS CHANGES-beta COPYING GETTING* INSTALL ISSUES PROBLEMS README*
}

