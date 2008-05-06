# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xsri/xsri-2.1.0.ebuild,v 1.6 2008/05/06 13:41:08 drac Exp $

inherit base rpm

DESCRIPTION="The xsri wallpaper setter from RedHat"
HOMEPAGE="http://fedora.redhat.com/"
SRC_URI="http://download.fedora.redhat.com/pub/fedora/linux/core/4/SRPMS/${P}-9.src.rpm"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~x86-fbsd"
IUSE=""

RDEPEND="=x11-libs/gtk+-2*"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	base_src_install "$@"
	dodoc AUTHORS README NEWS
}
