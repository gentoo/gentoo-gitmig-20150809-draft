# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cflow/cflow-1.2-r1.ebuild,v 1.1 2007/12/15 01:41:21 ulm Exp $

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

SITEFILE=50${PN}-gentoo.el

src_compile() {
	econf \
		$(use_enable nls) \
		$(use_enable debug) \
		EMACS=no \
		|| die "econf failed"
	emake || die "emake failed"

	if use emacs; then
		elisp-compile elisp/cflow-mode.el || die "elisp-compile failed"
	fi
}

src_install() {
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
	doinfo doc/cflow.info
	emake DESTDIR="${D}" install || die "emake install failed"

	if use emacs; then
		elisp-install ${PN} elisp/cflow-mode.{el,elc} \
			|| die "elisp-install failed"
		elisp-site-file-install "${FILESDIR}/${SITEFILE}" \
			|| die "elisp-site-file-install failed"
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
