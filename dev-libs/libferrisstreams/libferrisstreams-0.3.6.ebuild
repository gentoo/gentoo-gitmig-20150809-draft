# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libferrisstreams/libferrisstreams-0.3.6.ebuild,v 1.1 2004/04/13 04:26:13 vapier Exp $

inherit flag-o-matic

DESCRIPTION="Loki Standard C++ IOStreams extensions"
HOMEPAGE="http://witme.sourceforge.net/libferris.web/"
SRC_URI="mirror://sourceforge/witme/ferrisstreams-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="dev-libs/STLport
	>=dev-libs/libsigc++-1.2
	dev-libs/ferrisloki
	>=dev-libs/glib-2"

S=${WORKDIR}/ferrisstreams-${PV}

src_install() {
	make install DESTDIR=${D} || die
	dodoc AUTHORS ChangeLog NEWS README
}
