# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/tomboy-reminder/tomboy-reminder-0.9.1.ebuild,v 1.2 2009/01/25 17:10:50 loki_val Exp $

EAPI=2

inherit base mono

DESCRIPTION="Reminder Plugin for Tomboy"
HOMEPAGE="http://flukkost.nu/blog/tomboy-reminder/"
SRC_URI="http://flukkost.nu/${P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/mono-2.0
	 >=app-misc/tomboy-0.12"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.19"

PATCHES=(
	"${FILESDIR}/${PN}-0.9-unicode-regex.patch"
)

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc README NEWS ChangeLog AUTHORS || die "dodoc failed"
}
