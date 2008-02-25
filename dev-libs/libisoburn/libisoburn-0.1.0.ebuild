# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libisoburn/libisoburn-0.1.0.ebuild,v 1.1 2008/02/25 14:42:26 beandog Exp $

DESCRIPTION="Enables creation and expansion of ISO-9660 filesystems on all
CD/DVD media supported by libburn"
HOMEPAGE="http://libburnia-project.org/"
SRC_URI="http://files.libburnia-project.org/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=dev-libs/libburn-0.4.2
	>=dev-libs/libisofs-0.6.2.1"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12"

src_install() {

	emake DESTDIR="${D}" install || die "emake install died"
	dodoc AUTHORS README TODO

}
