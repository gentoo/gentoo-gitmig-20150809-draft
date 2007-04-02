# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/hal-info/hal-info-20070328.ebuild,v 1.3 2007/04/02 16:34:27 armin76 Exp $

inherit eutils

DESCRIPTION="The fdi scripts that HAL uses."
HOMEPAGE="http://hal.freedesktop.org"
SRC_URI="http://people.freedesktop.org/~david/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"

RDEPEND=">=sys-apps/hal-0.5.9_rc2"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-update_dtd.patch
}

src_compile() {
	econf --enable-recall --enable-video || die "econf failed."
	emake
}

src_install() {
	make DESTDIR="${D}" install || die "install failed."
}
