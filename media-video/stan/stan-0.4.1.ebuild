# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/stan/stan-0.4.1.ebuild,v 1.1 2005/01/17 18:12:44 kzimmerm Exp $

DESCRIPTION="Stan is a console application that analyzes binary streams and calculates statistical information."
HOMEPAGE="http://www.roqe.org/stan/"
SRC_URI="http://www.roqe.org/stan/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""

src_install() {
	einstall || die
}
