# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/swish-e/swish-e-2.2.2-r2.ebuild,v 1.2 2006/02/07 16:46:10 mcummings Exp $

inherit perl-module

DESCRIPTION="Simple Web Indexing System for Humans - Enhanced"
HOMEPAGE="http://www.swish-e.org/"
SRC_URI="http://www.swish-e.org/Download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="doc perl"

DEPEND=">=sys-libs/zlib-1.1.3
	dev-libs/libxml2
	dev-perl/libwww-perl"

src_compile() {
	econf || die "configuration failed"
	emake || die "emake failed"

	# closing stdin causes e-swish build system use a
	# non-interactive mode <mkennedy@gentoo.org>
	use perl && cd perl \
		&& exec <&- \
		&& perl-module_src_compile
}

src_install() {
	dobin src/swish-e || die "dobin failed"
	dodoc INSTALL README
	if use doc; then
		mkdir -p "${D}"/usr/share/doc/${PF}
		cp -r html conf "${D}"/usr/share/doc/${PF} || die "cp failed"
	fi
	use perl && cd perl \
		&& perl-module_src_install
}
