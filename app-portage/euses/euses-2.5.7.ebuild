# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/euses/euses-2.5.7.ebuild,v 1.1 2009/11/23 04:10:50 jer Exp $

DESCRIPTION="look up USE flag descriptions fast"
HOMEPAGE="http://www.xs4all.nl/~rooversj/gentoo"
SRC_URI="http://www.xs4all.nl/~rooversj/gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE=""

S="${WORKDIR}"

src_install() {
	dobin ${PN} || die
	doman ${PN}.1 || die
	dodoc ChangeLog || die
}
