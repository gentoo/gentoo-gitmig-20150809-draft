# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/valkyrie/valkyrie-1.3.0.ebuild,v 1.3 2008/11/26 00:45:04 flameeyes Exp $

EAPI=1
inherit eutils qt3 autotools

DESCRIPTION="Graphical front-end to the Valgrind suite of tools"
HOMEPAGE="http://www.open-works.co.uk/projects/valkyrie.html"
SRC_URI="http://www.valgrind.org/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug"

DEPEND="x11-libs/qt:3"
RDEPEND="${DEPEND}
	=dev-util/valgrind-3.3*"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-asneeded.patch"
	AT_M4DIR="m4" eautoreconf
}

src_compile() {
	use debug || sed -i -e '/#define DEBUG_ON/ s:1:0:' \
		"${S}/valkyrie/vk_utils.h"

	econf \
		--disable-dependency-tracking \
		--with-Qt-dir="${QTDIR}" || die "econf failed"

	# Use the right path for the documentation
	sed -i -e '/VK_DOC_PATH/ s:/doc/:/share/doc/'${PF}'/html/:g' \
		"${S}/config.h"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" docdir="/usr/share/doc/${PF}/html" install

	dodoc README README_DEVELOPERS AUTHORS
}
