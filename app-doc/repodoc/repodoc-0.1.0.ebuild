# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/repodoc/repodoc-0.1.0.ebuild,v 1.2 2008/01/09 16:01:25 yoswink Exp $

inherit mono

DESCRIPTION="Package designed to work with Gentoo official docs"
HOMEPAGE="http://dev.gentoo.org/~yoswink/repodoc/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="gtk"

RDEPEND="${DEPEND}
	|| ( sys-apps/gawk sys-apps/mawk sys-apps/busybox )"

DEPEND="dev-libs/libxml2
	dev-util/pkgconfig
	gtk? ( dev-dotnet/gtk-sharp )"

src_compile() {
	econf $(use_enable gtk) || die 'econf failed!'
	emake || die 'emake failed!'
}

src_install() {
	make DESTDIR="${D}" install || die 'install failed!'
	dodoc AUTHORS ChangeLog
}
