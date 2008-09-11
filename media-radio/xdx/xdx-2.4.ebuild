# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/xdx/xdx-2.4.ebuild,v 1.1 2008/09/11 19:16:36 darkside Exp $

DESCRIPTION="a GTK+ TCP/IP DX-cluster and ON4KST chat client."
HOMEPAGE="http://www.qsl.net/pg4i/linux/xdx.html"
SRC_URI="http://www.qsl.net/pg4i/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="nls"

RDEPEND=">=x11-libs/gtk+-2.12"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

src_compile() {
	econf $(use_enable nls)
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README TODO
}

pkg_postinst() {
	elog "To use the rig control feature, install media-libs/hamlib"
	elog "and enable hamlib in the Preferences dialog. (no need for recompile)"
}
