# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libisoburn/libisoburn-0.3.2_p0.ebuild,v 1.1 2009/02/01 02:42:35 loki_val Exp $

EAPI=2

inherit base

DESCRIPTION="Enables creation and expansion of ISO-9660 filesystems on all CD/DVD media supported by libburn"
HOMEPAGE="http://libburnia-project.org/"
SRC_URI="http://files.libburnia-project.org/releases/${P/_p/.pl0}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/libburn-0.6.0
	>=dev-libs/libisofs-0.6.12"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${P/_p0}

src_configure() {
	econf --disable-static
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS README TODO
	find "${D}" -name '*.la' -exec rm -rf '{}' '+' || die "la removal failed"
}
