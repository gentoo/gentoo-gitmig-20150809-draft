# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/librtfcomp/librtfcomp-1.1.ebuild,v 1.1 2011/02/25 22:12:56 ssuominen Exp $

EAPI=3

PYTHON_DEPEND="python? 2:2.6"

inherit autotools python

DESCRIPTION="A library for SynCE"
HOMEPAGE="http://www.synce.org/"
SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="python static-libs"

RDEPEND="python? ( >=dev-python/pyrex-0.9.6 )"
DEPEND="${RDEPEND}"

pkg_setup() {
	if use python; then
		python_set_active_version 2
		python_pkg_setup
	fi
}

src_prepare() {
	sed -i -e '/bin_PROGRAMS/d' tests/Makefile.am || die
	eautoreconf
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable static-libs static) \
		$(use_enable python python-bindings)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc CHANGELOG

	find "${D}" -name '*.la' -exec rm -f {} +
}
