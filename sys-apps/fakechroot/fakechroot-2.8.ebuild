# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/fakechroot/fakechroot-2.8.ebuild,v 1.1 2008/09/07 10:59:42 spock Exp $

inherit eutils

DESCRIPTION="Provide a faked chroot environment without requiring root privileges"
HOMEPAGE="http://fakechroot.alioth.debian.org/"
SRC_URI="mirror://debian/pool/main/f/fakechroot/${PF/-/_}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND=""

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README THANKS
}
