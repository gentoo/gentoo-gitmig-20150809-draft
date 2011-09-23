# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/libtextcat/libtextcat-3.0.1.ebuild,v 1.1 2011/09/23 14:19:39 scarabeus Exp $

EAPI=4

MY_P="libexttextcat-${PV}"

DESCRIPTION="Library implementing N-gram-based text categorization"
HOMEPAGE="http://software.wise-guys.nl/libtextcat/"
SRC_URI="http://dev-www.libreoffice.org/src/${MY_P}.tar.xz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_configure() {
	econf \
		--disable-werror \
		--disable-static
}

src_install() {
	default
	find "${ED}" -name '*.la' -exec rm -f {} +
}
