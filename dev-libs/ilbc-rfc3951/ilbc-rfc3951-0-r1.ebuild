# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ilbc-rfc3951/ilbc-rfc3951-0-r1.ebuild,v 1.10 2009/12/17 16:33:17 armin76 Exp $

inherit eutils autotools

DESCRIPTION="iLBC (internet Low Bitrate Codec) is a speech codec suitable for robust voice communication over IP."
HOMEPAGE="http://www.ilbcfreeware.org/"
SRC_URI="http://simon.morlat.free.fr/download/1.1.x/source/ilbc-rfc3951.tar.gz"
# http://www.ilbcfreeware.org/documentation/gips_iLBClicense.pdf
LICENSE="gips_iLBClicense.pdf"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ppc ~ppc64 ~sparc x86"
RESTRICT="bindist"

IUSE=""
S="${WORKDIR}/${PN}"
DEPEND=""
src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-asneeded.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
}
