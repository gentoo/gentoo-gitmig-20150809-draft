# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/esorex/esorex-3.9.0.ebuild,v 1.1 2011/04/08 04:48:13 bicatali Exp $

EAPI=4

DESCRIPTION="ESO Recipe Execution Tool to exec cpl scripts"
HOMEPAGE="http://www.eso.org/sci/software/cpl/esorex.html"
SRC_URI="ftp://ftp.eso.org/pub/cpl/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

DEPEND=">=sci-astronomy/cpl-5.2"
RDEPEND="${DEPEND}"

src_install() {
	default
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
