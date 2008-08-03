# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdemu/cdemu-1.1.0.ebuild,v 1.1 2008/08/03 21:12:20 vanquirius Exp $

DESCRIPTION="Client of cdemu suite, which mounts all kinds of cd images"
HOMEPAGE="http://cdemu.org"
SRC_URI="mirror://sourceforge/cdemu/cdemu-client-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/python-2.4
	dev-python/dbus-python
	app-cdr/cdemud"
DEPEND="${RDEPEND}
	dev-util/intltool"

S=${WORKDIR}/cdemu-client-${PV}

src_install() {
	emake install DESTDIR="${D}" || die "install failed"
	dodoc AUTHORS ChangeLog README
}
