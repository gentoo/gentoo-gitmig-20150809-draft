# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/librapi2/librapi2-0.15.2.ebuild,v 1.2 2011/02/25 15:29:08 ssuominen Exp $

EAPI=3

PYTHON_DEPEND="python? 2:2.6"

inherit python

DESCRIPTION="A library for SynCE"
HOMEPAGE="http://www.synce.org/"
SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dbus python static-libs"

RDEPEND=">=dev-libs/libsynce-0.15.1[dbus?]
	dbus? ( >=dev-libs/dbus-glib-0.88 )
	python? ( >=dev-python/pyrex-0.9.6 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

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
		$(use_enable dbus odccm-support) \
		--disable-hal-support \
		$(use_enable dbus udev-support) \
		$(use_enable python python-bindings)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc BUGS ChangeLog README* TODO

	find "${D}" -name '*.la' -exec rm -f {} +
}
