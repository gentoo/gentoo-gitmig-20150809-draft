# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/fakeroot-ng/fakeroot-ng-0.14.ebuild,v 1.3 2008/10/28 02:12:04 mr_bones_ Exp $

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
