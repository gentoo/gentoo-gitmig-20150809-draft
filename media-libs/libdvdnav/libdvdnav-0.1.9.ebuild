# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdvdnav/libdvdnav-0.1.9.ebuild,v 1.14 2005/02/06 11:27:17 vapier Exp $

inherit eutils flag-o-matic

DESCRIPTION="Library for DVD navigation tools"
HOMEPAGE="http://sourceforge.net/projects/dvd/"
SRC_URI="mirror://sourceforge/dvd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 ~ppc-macos sparc x86"
IUSE=""

DEPEND="media-libs/libdvdread"

src_unpack() {
	unpack ${A}
	use ppc-macos && epatch ${FILESDIR}/${P}-darwin.diff
}

src_compile() {
	use ppc-macos && append-flags -D__DARWIN__
	econf || die "./configure failed"
	emake || die "make failed"
}

src_install () {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS INSTALL NEWS README
}

pkg_postinst() {
	einfo
	einfo "Please remove old versions of libdvdnav manually,"
	einfo "having multiple versions installed can cause problems."
	einfo
}
