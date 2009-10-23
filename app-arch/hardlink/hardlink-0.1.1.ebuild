# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/hardlink/hardlink-0.1.1.ebuild,v 1.2 2009/10/23 09:18:39 robbat2 Exp $

DESCRIPTION="replace file copies using hardlinks"
HOMEPAGE="http://jak-linux.org/projects/hardlink/"
SRC_URI="${HOMEPAGE}/${P/-/_}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND=""
RDEPEND="dev-lang/python"

src_install() {
	emake DESTDIR="${D}" install || die "Failed emake install"
}
