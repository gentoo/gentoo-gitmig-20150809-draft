# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/liblrdf/liblrdf-0.3.3.ebuild,v 1.1 2004/01/26 14:29:15 torbenh Exp $

DESCRIPTION="A library for the manipulation of RDF file in LADSPA plugins"
HOMEPAGE="http://plugin.org.uk"
SRC_URI="http://plugin.org.uk/releases/lrdf/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc"
IUSE=""
DEPEND="virtual/glibc
	>=media-libs/raptor-0.9.12
	>=media-libs/ladspa-sdk-1.12"
S=${WORKDIR}/${P}

src_compile() {
	econf
	emake || die
}

src_install() {
	einstall
}
