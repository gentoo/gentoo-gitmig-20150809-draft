# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libsigc++/libsigc++-1.2.3.ebuild,v 1.3 2003/05/16 12:57:16 foser Exp $

S=${WORKDIR}/${P}
IUSE=""
DESCRIPTION="The GLib library of C routines"
SRC_URI="mirror://sourceforge/libsigc/${P}.tar.gz"
HOMEPAGE="http://libsigc.sourceforge.net/"
SLOT="1.2"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="x86 ~ppc ~sparc "

DEPEND="virtual/glibc"

src_compile() {
	local myconf
    
	if [ "${DEBUG}" ]
	then
		myconf="--enable-debug=yes"
	else
		myconf="--enable-debug=no"
	fi
    
	econf ${myconf} --enable-threads || die
	emake || die "emake failure"
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog FEATURES IDEAS COPYING* \
		README INSTALL NEWS TODO
}

pkg_postinst() {
	ewarn "To allow parallel installation of sig++-1.0 and sig++-1.2,"
	ewarn "the header files are now installed in a version specific"
	ewarn "subdirectory.  Be sure to unmerge any libsig++ versions"
	ewarn "< 1.0.4 that you may have previously installed."
}
