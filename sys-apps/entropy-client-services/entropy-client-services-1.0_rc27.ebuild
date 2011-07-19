# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/entropy-client-services/entropy-client-services-1.0_rc27.ebuild,v 1.2 2011/07/19 12:39:29 lxnay Exp $

EAPI="3"
PYTHON_DEPEND="2"
inherit eutils python

DESCRIPTION="Entropy Package Manager client-side services"
HOMEPAGE="http://www.sabayon.org"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
SRC_URI="mirror://sabayon/sys-apps/entropy-${PV}.tar.bz2"

S="${WORKDIR}/entropy-${PV}"

DEPEND=""
RDEPEND="dev-python/dbus-python
	dev-python/pygobject:2
	>=sys-apps/dbus-1.2.6
	~sys-apps/entropy-${PV}"

src_compile() {
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" LIBDIR="usr/$(get_libdir)" updates-daemon-install || die "make install failed"
}

pkg_postinst() {
	python_mod_optimize "/usr/$(get_libdir)/entropy/services"
}

pkg_postrm() {
	python_mod_cleanup "/usr/$(get_libdir)/entropy/services"
}
