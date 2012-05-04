# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/librra/librra-0.14.ebuild,v 1.2 2012/05/04 18:35:56 jdhore Exp $

EAPI=3

PYTHON_DEPEND="python? 2:2.6"

inherit python

DESCRIPTION="A library for SynCE"
HOMEPAGE="http://www.synce.org/"
SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="python recurrence static-libs"

RDEPEND="dev-libs/libmimedir
	>=dev-libs/librapi2-0.14
	>=dev-libs/libsynce-0.14
	python? ( >=dev-python/pyrex-0.9.6 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

pkg_setup() {
	if use python; then
		python_set_active_version 2
		python_pkg_setup
	fi
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable static-libs static) \
		$(use_enable recurrence) \
		$(use_enable python python-bindings)
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc ChangeLog README TODO
	newdoc lib/README README.lib

	find "${D}" -name '*.la' -exec rm -f {} +
}
