# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cflow/cflow-1.0.ebuild,v 1.2 2007/01/04 04:26:50 beandog Exp $

DESCRIPTION="C function call hierarchy analyzer"
HOMEPAGE="http://www.gnu.org/software/cflow/"
SRC_URI="ftp://download.gnu.org.ua/pub/release/cflow/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug nls"

DEPEND="
	nls? ( sys-devel/gettext )
"
RDEPEND=""

src_compile() {

	econf \
		$(use_enable nls) \
		$(use_enable debug) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install
}
