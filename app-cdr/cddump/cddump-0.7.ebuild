# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cddump/cddump-0.7.ebuild,v 1.13 2004/03/12 11:51:30 mr_bones_ Exp $

DESCRIPTION="cddump - backup to CD-Recordable and CD-Rewritable"
SRC_URI="http://www.joat.ca/software/${P}.tar.gz"
HOMEPAGE="http://www.joat.ca/software/cddump.html"
SLOT="0"
LICENSE="GPL-2"
DEPEND="app-cdr/cdrtools
	dev-lang/perl"
KEYWORDS="x86 ppc sparc"

src_unpack() {
	unpack ${A}
	cd ${S}

	cat install.cddump | sed \
		-e "/system/s:/usr/local/man/man8:${D}usr/man/man8:" > install.cddump.NEW
	mv install.cddump.NEW install.cddump
}

src_compile() {
	# These are appropriate defaults for my system (with an 8x
	# writer).  I don't know if these defaults will be appropriate for
	# other systems.
	( echo /usr/bin/perl
	  echo /usr/bin/mkisofs
	  echo /usr/bin/cdrecord
	  echo /usr/bin/cpio
	  echo /dev/sg0
	  echo 8
	  echo .
	  echo y
	) | perl install.cddump
}

src_install() {
	# Include the source in the documentation so that the user can be
	# free to rerun the install.
	dobin cddump
	dodoc cddump.in CHANGELOG install.cddump LICENCE README TUTORIAL
	doman cddump.8
}

pkg_postinst() {
	echo
	einfo "Cddump has been configured for an 8x writer at /dev/sg0."
	einfo "To reconfigure, please run \"perl /usr/share/doc/${P}/cddump.in\""
	echo
}
