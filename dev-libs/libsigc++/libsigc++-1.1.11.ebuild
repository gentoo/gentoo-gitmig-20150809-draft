# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libsigc++/libsigc++-1.1.11.ebuild,v 1.6 2002/08/14 11:52:27 murphy Exp $


# unstable branch should have debugging. 
inherit debug


S=${WORKDIR}/${P}
DESCRIPTION="The GLib library of C routines"
SRC_URI="http://download.sourceforge.net/libsigc/${P}.tar.gz"
HOMEPAGE="http://libsigc.sourceforge.net/"

SLOT="1.2"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND="virtual/glibc"

src_compile() {

	local myconf
    
	if [ "${DEBUG}" ]
	then
		myconf="--enable-debug=yes"
	else
		myconf="--enable-debug=no"
	fi
    
	econf ${myconf} || die
	
	# Fix sandbox violation when old libsig++ is already installed,
	# hopefully this will go away after the header location settles down
	# Comment out the remove old header directory line
	
#	cp sigc++/Makefile sigc++/Makefile.orig
#	sed -e 's:\(@if\):#\1:' \
#		sigc++/Makefile.orig > sigc++/Makefile
	
	# This occurs in two places
	
#	cp sigc++/config/Makefile sigc++/config/Makefile.orig
#	sed -e 's:\(@if\):#\1:' \
#        sigc++/config/Makefile.orig > sigc++/config/Makefile
		
	emake || die "emake failure"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING README* INSTALL NEWS
}

pkg_postinst() {
	einfo "************************* WARNING ************************"
	einfo ""
	einfo "To allow parallel installation of sig++-1.0 and sig++-1.2,"
	einfo "the header files are now installed in a version specific"
	einfo "subdirectory.  Be sure to unmerge any libsig++ versions"
	einfo "< 1.0.4 that you may have previously installed."
	einfo ""
	einfo "**********************************************************"
}
