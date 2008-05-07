# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/log4cpp/log4cpp-1.0.ebuild,v 1.2 2008/05/07 08:29:30 dev-zero Exp $

NEED_AUTOCONF="latest"
NEED_AUTOMAKE="latest"

inherit autotools eutils

KEYWORDS="~x86 ~ppc ~amd64 ~s390"

DESCRIPTION="Library of C++ classes for flexible logging to files, syslog and other destinations."
HOMEPAGE="http://log4cpp.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE="doc"

DEPEND="doc? ( app-doc/doxygen )"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${PV}-doc_install_path.patch" \
		"${FILESDIR}/${PV}-gcc43.patch"

	AT_M4DIR=m4
	eautoreconf
}

src_compile() {
	econf \
		--without-idsa \
		$(use_enable doc doxygen) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
}
