# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/profuse/profuse-0.17.ebuild,v 1.3 2005/07/09 02:35:44 swegener Exp $

DESCRIPTION="use flags and profile gtk2 editor, with good features"
HOMEPAGE="http://libconf.net/profuse/"
SRC_URI="http://libconf.net/profuse/download/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64"
IUSE=""

RDEPEND=">=dev-perl/gtk2-fu-0.05
>=dev-util/libconf-0.39.9"

src_install() {
	make install PREFIX="${D}"/usr || die "make install failed"
}
