# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ben Lutgens <lamer@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gdkxft/gdkxft-1.0.ebuild,v 1.1 2001/09/03 00:13:56 lamer Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Add anti-aliasing to your GTK+ 1.2 apps"
SRC_URI="http://philrsss.anu.edu.au/~josh/gdkxft/${P}.tar.gz"
HOMEPAGE="http://philrsss.anu.edu.au/~josh/gdkxft/"
DEPEND=">=x11-libs/gtk+-1.2.10
		  virtual/x11"

#RDEPEND=""

src_compile() {
	try ./configure --infodir=/usr/share/info \
	--mandir=/usr/share/man --prefix=/usr --host=${CHOST}
	
	emake || die
}

src_install () {
	
	# try make prefix=${D}/usr install

    try make DESTDIR=${D} install
	 dodoc README INSTALL ChangeLog NEWS AUTHORS COPYING 
	 einfo "Now run ebuild /var/db/pkg/x11-libs/gdkxft-1.0/gdkxft-1.0.ebuild
config"
	 einfo "to finish setting up. This will configure your Xft library
correctly"
}

pkg_config() {
	einfo "running gdkxft_sysinstall -f"
   gdkxft_sysinstall -f || die
}
