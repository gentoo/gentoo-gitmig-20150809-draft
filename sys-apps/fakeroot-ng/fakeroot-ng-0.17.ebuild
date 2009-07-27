# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/fakeroot-ng/fakeroot-ng-0.17.ebuild,v 1.1 2009/07/27 07:03:42 spock Exp $

DESCRIPTION="A utility to run commands with fake root privileges"
HOMEPAGE="http://sourceforge.net/projects/fakerootng/"
SRC_URI="mirror://sourceforge/${PN//-/}/${PF}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=""
DEPEND=""

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README NEWS AUTHORS
}
