# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/syrep/syrep-0.9.ebuild,v 1.1 2008/01/16 16:06:54 armin76 Exp $

inherit eutils autotools

DESCRIPTION="A p2p generic file repository synchronization tool that may be used to synchronize large file hierarchies bidirectionally by exchanging patch files."
HOMEPAGE="http://0pointer.de/lennart/projects/syrep/"
SRC_URI="http://0pointer.de/lennart/projects/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

DEPEND="sys-libs/zlib
	>=sys-libs/db-4.3
	doc? ( www-client/lynx )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i -e "s/#if (DB_VERSION_MAJOR != 4).*/#if (DB_VERSION_MAJOR != 4)/" configure.ac

	eautoreconf
}
src_compile() {
	econf \
		$(use_enable doc lynx) \
		--disable-xmltoman \
		--disable-subversion \
		--disable-gengetopt \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	cd "${S}"/doc
	dodoc README *.txt
	use doc && dohtml *.html *.css
}
