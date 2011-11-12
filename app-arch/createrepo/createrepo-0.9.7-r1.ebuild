# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/createrepo/createrepo-0.9.7-r1.ebuild,v 1.1 2011/11/12 19:37:12 maksbotan Exp $

EAPI="3"

PYTHON_DEPEND="2:2.6"
PYTHON_USE_WITH="xml"

inherit python

DESCRIPTION="Creates a common metadata repository"
HOMEPAGE="http://createrepo.baseurl.org/"
SRC_URI="http://createrepo.baseurl.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=dev-python/urlgrabber-2.9.0
	>=app-arch/rpm-4.0[python]
	dev-libs/libxml2[python]"

pkg_setup() {
	python_pkg_setup
	python_set_active_version 2
}

src_compile() { :; }

src_install() {
	emake install DESTDIR="${ED}" || die
	dodoc ChangeLog README
	python_convert_shebangs -r 2 "${ED}"
}
