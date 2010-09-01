# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/dvdbackup/dvdbackup-0.4.1.ebuild,v 1.4 2010/09/01 19:41:40 billie Exp $

EAPI="2"

DESCRIPTION="Backup content from DVD to hard disk"
HOMEPAGE="http://dvdbackup.sourceforge.net/"
SRC_URI="mirror://sourceforge/project/${PN}/${PN}/${P}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-solaris"
IUSE="nls"

DEPEND=">=media-libs/libdvdread-4.1.3_p1217
	nls? ( virtual/libintl )"
RDEPEND="${DEPEND}"

src_configure() {
	econf \
		$(use_enable nls) \
		--disable-dependency-tracking \
		--disable-rpath \
		--docdir="/usr/share/doc/${PF}"
}

src_install() {
	emake DESTDIR="${D}" install || die 'emake install failed'
	dodoc AUTHORS ChangeLog NEWS README || die 'dodoc failed'
}
