# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xsri/xsri-2.1.0-r1.ebuild,v 1.3 2006/10/01 15:34:55 tester Exp $

inherit base rpm

DESCRIPTION="The xsri wallpaper setter from RedHat"
HOMEPAGE="http://fedora.redhat.com/"
SRC_URI="http://download.fedora.redhat.com/pub/fedora/linux/core/5/source/SRPMS/${P}-9.2.1.src.rpm"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="=x11-libs/gtk+-2*"

src_install() {
	base_src_install "$@"
	dodoc AUTHORS README NEWS
}
