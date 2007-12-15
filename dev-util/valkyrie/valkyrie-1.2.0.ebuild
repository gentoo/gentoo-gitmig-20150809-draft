# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/valkyrie/valkyrie-1.2.0.ebuild,v 1.5 2007/12/15 13:35:43 flameeyes Exp $

inherit eutils qt3

DESCRIPTION="Graphical front-end to the Valgrind suite of tools"
HOMEPAGE="http://www.open-works.co.uk/projects/valkyrie.html"
SRC_URI="http://www.valgrind.org/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug"

DEPEND="$(qt_min_version 3)"
RDEPEND="${DEPEND}
	=dev-util/valgrind-3.2*"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-warnings.patch"
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
