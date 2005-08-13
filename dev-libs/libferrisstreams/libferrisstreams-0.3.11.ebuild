# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libferrisstreams/libferrisstreams-0.3.11.ebuild,v 1.3 2005/08/13 23:14:24 hansmi Exp $

inherit flag-o-matic

DESCRIPTION="Loki Standard C++ IOStreams extensions"
HOMEPAGE="http://witme.sourceforge.net/libferris.web/"
SRC_URI="mirror://sourceforge/witme/ferrisstreams-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND=">=dev-libs/STLport-4.6.2-r1
	>=dev-libs/libsigc++-1.2
	dev-libs/ferrisloki
	>=dev-libs/glib-2"

S=${WORKDIR}/ferrisstreams-${PV}

src_install() {
	make install DESTDIR=${D} || die
	dodoc AUTHORS ChangeLog NEWS README
}
