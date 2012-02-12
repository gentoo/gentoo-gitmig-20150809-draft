# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/entropy-client-services/entropy-client-services-1.0_rc87.ebuild,v 1.1 2012/02/12 07:23:24 lxnay Exp $

EAPI="3"
PYTHON_DEPEND="2"
inherit eutils python

DESCRIPTION="Entropy Package Manager client-side services"
HOMEPAGE="http://www.sabayon.org"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
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
	emake DESTDIR="${D}" LIBDIR="usr/lib" updates-daemon-install || die "make install failed"
}
