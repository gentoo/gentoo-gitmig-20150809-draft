# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/libspf2/libspf2-1.0.4.ebuild,v 1.1 2004/07/25 15:53:26 pfeifer Exp $

DESCRIPTION="libspf2 implements the Sender Policy Framework, a part of the SPF/SRS protocol pair."
HOMEPAGE="http://www.libspf2.org/"
SRC_URI="http://www.libspf2.org/spf/libspf2-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/libc"
RDEPEND=""

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR=${D} || die "make install failed"

	dodoc Changelog INSTALL README TODO docs/*.txt docs/API
}

pkg_postinst() {
	einfo "${P} was successfully installed."
	einfo "Please read the associated docs for help."
	einfo "Or visit the website @ ${HOMEPAGE}"
	echo
	ewarn "This package is still in unstable."
	ewarn "Please report bugs to http://bugs.gentoo.org/"
	ewarn "However, please do an advanced query to search for bugs"
	ewarn "before reporting. This will keep down on duplicates."
}
