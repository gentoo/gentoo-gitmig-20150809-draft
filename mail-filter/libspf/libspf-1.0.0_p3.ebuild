# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/libspf/libspf-1.0.0_p3.ebuild,v 1.1 2005/05/10 01:19:32 pfeifer Exp $

RESTRICT="nomirror"
DESCRIPTION="libspf - An ANSI C Implementation of Sender Policy Framework."
HOMEPAGE="http://libspf.org/"
MY_P=${PN}-${PV/_p/-p}
SRC_URI="http://libspf.org/files/src/${MY_P}.tar.bz2"

LICENSE="libSPF"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/libc"
RDEPEND=""

S=${WORKDIR}/${MY_P}

src_compile() {
	econf || die "econf failed"
	make all CFLAGS="${CFLAGS}" || die "make failed"
}

src_install() {
	make install DESTDIR=${D} || die "make install failed"

	dohtml docs/spfqtool/*.html
	dodoc Changelog INSTALL README TODO docs/{API,RFC}/*.txt docs/history/CHANGELOG*
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
