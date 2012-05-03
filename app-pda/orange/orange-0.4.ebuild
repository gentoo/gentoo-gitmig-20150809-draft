# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/orange/orange-0.4.ebuild,v 1.4 2012/05/03 20:20:58 jdhore Exp $

EAPI=2

MY_P=lib${P}

DESCRIPTION="A tool and library for extracting cabs from executable installers."
HOMEPAGE="http://synce.sourceforge.net/synce/orange.php"
SRC_URI="mirror://sourceforge/synce/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

RDEPEND="dev-libs/libsynce
	>=app-pda/dynamite-0.1.1
	>=app-arch/unshield-0.5.1
	sys-apps/file
	sys-libs/zlib"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/${MY_P}

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog TODO

	find "${D}" -name '*.la' -exec rm -f {} +
}
