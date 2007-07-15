# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cflow/cflow-1.2.ebuild,v 1.1 2007/07/15 20:24:48 dev-zero Exp $

inherit elisp-common

DESCRIPTION="C function call hierarchy analyzer"
HOMEPAGE="http://www.gnu.org/software/cflow/"
SRC_URI="ftp://download.gnu.org.ua/pub/release/cflow/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug emacs nls"

DEPEND="nls? ( sys-devel/gettext )
	emacs? ( virtual/emacs )"
RDEPEND="${DEPEND}"

SITEFILE=cflow-mode.el

src_compile() {
	econf \
		$(use_enable nls) \
		$(use_enable debug) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
	doinfo doc/cflow.info
	emake DESTDIR="${D}" install || die "emake install failed"

	use emacs && elisp-site-file-install "${S}/elisp/${SITEFILE}"
}

pkg_postinst() {
	use emacs && elisp-site-regen
}
