# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/hal-info/hal-info-20081219.ebuild,v 1.1 2009/01/18 18:40:55 eva Exp $

inherit eutils

DESCRIPTION="The fdi scripts that HAL uses"
HOMEPAGE="http://hal.freedesktop.org/"
SRC_URI="http://hal.freedesktop.org/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=sys-apps/hal-0.5.10"
DEPEND="${RDEPEND}"

src_compile() {
	econf
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed."
}
