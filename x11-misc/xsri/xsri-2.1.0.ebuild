# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xsri/xsri-2.1.0.ebuild,v 1.1 2005/11/01 15:42:29 nelchael Exp $

inherit base rpm

DESCRIPTION="The xsri wallpaper setter from RedHat"
HOMEPAGE="http://fedora.redhat.com/"
SRC_URI="http://download.fedora.redhat.com/pub/fedora/linux/core/4/SRPMS/${P}-9.src.rpm"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/x11
	=x11-libs/gtk+-2*"

src_install() {
	base_src_install "$@"
	dodoc AUTHORS README NEWS
}
