# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ilbc-rfc3951/ilbc-rfc3951-0.ebuild,v 1.3 2006/05/11 13:27:11 dertobi123 Exp $

DESCRIPTION="iLBC (internet Low Bitrate Codec) is a speech codec suitable for robust voice communication over IP."
HOMEPAGE="http://www.ilbcfreeware.org/"
SRC_URI="http://simon.morlat.free.fr/download/1.1.x/source/ilbc-rfc3951.tar.gz"
# http://www.ilbcfreeware.org/documentation/gips_iLBClicense.pdf
LICENSE="gips_iLBClicense.pdf"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE=""
S="${WORKDIR}/${PN}"
DEPEND=""

src_install() {
	make DESTDIR=${D} install || die
}
