# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/upslug2/upslug2-11.ebuild,v 1.3 2010/09/16 06:23:45 vapier Exp $

DESCRIPTION="util for flashing NSLU2 machines remotely"
HOMEPAGE="http://www.nslu2-linux.org/wiki/Main/UpSlug2"
SRC_URI="mirror://sourceforge/nslu/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ~arm x86"
IUSE=""

src_install() {
	emake install DESTDIR="${D}" || die
	mv "${D}"/usr/{sbin,bin} || die
	fperms 4711 /usr/bin/upslug2
	dodoc AUTHORS ChangeLog NEWS README*
}
