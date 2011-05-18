# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/complexity/complexity-0.4.ebuild,v 1.3 2011/05/18 02:35:43 jer Exp $

EAPI=3

# TODO: inherit autotools

DESCRIPTION="a tool designed for analyzing the complexity of C program
functions"
HOMEPAGE="http://www.gnu.org/software/complexity/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE=""

DEPEND=">=sys-devel/autogen-5.11.7"
RDEPEND=""

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog
}
