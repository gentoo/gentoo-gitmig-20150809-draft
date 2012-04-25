# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/complexity/complexity-0.4.ebuild,v 1.4 2012/04/25 00:29:16 jer Exp $

EAPI=4

DESCRIPTION="a tool designed for analyzing the complexity of C program
functions"
HOMEPAGE="http://www.gnu.org/software/complexity/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE=""

RDEPEND="
	>=sys-devel/autogen-5.11.7
"
DEPEND="
	${RDEPEND}
	sys-devel/libtool
"

DOCS=( ChangeLog )
