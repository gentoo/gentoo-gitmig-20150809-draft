# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/liblrdf/liblrdf-0.3.7.ebuild,v 1.12 2007/02/03 23:21:23 beandog Exp $

DESCRIPTION="A library for the manipulation of RDF file in LADSPA plugins"
HOMEPAGE="http://plugin.org.uk"
SRC_URI="mirror://sourceforge/lrdf/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ppc amd64 ~ppc-macos ppc64"
IUSE=""
RDEPEND=">=media-libs/raptor-0.9.12
	>=media-libs/ladspa-sdk-1.12"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
