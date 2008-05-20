# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdemu/cdemu-1.0.0.ebuild,v 1.1 2008/05/20 02:28:13 vanquirius Exp $

DESCRIPTION="Client of cdemu suite, which mounts all kinds of cd images"
HOMEPAGE="http://cdemu.org"
SRC_URI="mirror://sourceforge/cdemu/cdemu-client-${PV}.tar.bz2"

S="${WORKDIR}/cdemu-client-${PV}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.4
	dev-python/dbus-python
	dev-util/intltool"
RDEPEND="${DEPEND}
	app-cdr/cdemud"

src_install() {
	emake install DESTDIR="${D}" || die "install failed"
	dodoc AUTHORS ChangeLog README
}
