# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: System Team <system@gentoo.org>
# Author: Achim Gottinger <achim@gentoo.org>, Daniel Robbins <drobbins@gentoo.org>
# /home/cvsroot/gentoo-x86/app-editors/gtk-xemacs/gtk-xemacs-21.1.12_p3.ebuild,v 1.3 2000/10/29 20:36:58 achim Exp
# $Header: /var/cvsroot/gentoo-x86/app-editors/xemacs/xemacs-21.1.14.ebuild,v 1.5 2001/10/24 15:26:36 drobbins Exp $


S=${WORKDIR}/${P}
DESCRIPTION="XEmacs"
# The latest versions available are 1.26 and 1.55, respectively
EFS=1.26
BASE=1.55

DEPEND=">=x11-base/xfree-4.0.3-r3"

SRC_URI="ftp://ftp.xemacs.org/pub/current/${P}.tar.bz2
	 ftp://ftp.xemacs.org/xemacs/packages/efs-${EFS}-pkg.tar.gz
	 ftp://ftp.xemacs.org/xemacs/packages/xemacs-base-${BASE}-pkg.tar.gz"
	 
HOMEPAGE="http://www.xemacs.org"

src_unpack() {
	cd ${WORKDIR}
	unpack ${P}.tar.bz2			
	# Extract the original package
}

src_compile() {                           
	./configure --prefix=/usr/X11R6 || die
	make || die
}

src_install() {                               
	make prefix=${D}/usr/X11R6 install || die
	# Install the two packages
	dodir /usr/X11R6/lib/xemacs/xemacs-packages/
	cd ${D}/usr/X11R6/lib/xemacs/xemacs-packages/
	unpack efs-${EFS}-pkg.tar.gz
	unpack xemacs-base-${BASE}-pkg.tar.gz
	cd ${S}
	#this next line shouldn't be needed; info should be going to /usr/share/info
	#prepinfo /usr/X11R6/lib/xemacs-21.1.14
	dodoc BUGS CHANGES-beta COPYING GETTING* INSTALL ISSUES PROBLEMS README*
}

