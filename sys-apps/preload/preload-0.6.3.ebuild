# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/preload/preload-0.6.3.ebuild,v 1.1 2008/10/18 02:20:48 darkside Exp $

DESCRIPTION="Adaptive readahead daemon."
HOMEPAGE="http://sourceforge.net/projects/preload"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-libs/glib"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	econf --localstatedir=/var
	emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	rm -rf "${D}/etc/rc.d" || die "rm rc.d failed"
	newinitd "${FILESDIR}/init.d-preload" preload || die "initd failed"
	newconfd "${FILESDIR}/conf.d-preload" preload || die "confd failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
}

