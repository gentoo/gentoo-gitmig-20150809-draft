# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/fmt-ptrn/fmt-ptrn-1.3.19.ebuild,v 1.1 2009/01/14 03:16:38 vapier Exp $

# XXX: this has auto-depend on sys-libs/pwdb and sys-libs/zlib

DESCRIPTION="template system useful when used with a simple text editor (like vi)"
HOMEPAGE="http://www.flyn.org/projects/fmt-ptrn/"
SRC_URI="http://www.flyn.org/projects/fmt-ptrn/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README TODO
}
