# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xdg-utils/xdg-utils-1.0_beta3.ebuild,v 1.5 2006/08/19 20:20:26 dertobi123 Exp $

MY_P="${P/_}"
DESCRIPTION="Portland utils for cross-platform/cross-toolkit/cross-desktop interoperability"
HOMEPAGE="http://portland.freedesktop.org/wiki/Portland"
SRC_URI="http://portland.freedesktop.org/download/${MY_P}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~hppa ~ppc ~ppc64 ~x86"
IUSE=""
RESTRICT="test"

DEPEND=""
RDEPEND=""
S="${WORKDIR}/${MY_P}"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc README TODO
}
