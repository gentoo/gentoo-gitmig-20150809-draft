# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cflow/cflow-1.2-r2.ebuild,v 1.1 2009/02/02 20:45:35 ulm Exp $

inherit elisp-common eutils

DESCRIPTION="C function call hierarchy analyzer"
HOMEPAGE="http://www.gnu.org/software/cflow/"
SRC_URI="ftp://download.gnu.org.ua/pub/release/cflow/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug emacs nls"

DEPEND="nls? ( sys-devel/gettext )
	emacs? ( virtual/emacs )"
RDEPEND="${DEPEND}"

SITEFILE="50${PN}-gentoo.el"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-info-direntry.patch"
}

src_compile() {
	econf \
		$(use_enable nls) \
		$(use_enable debug) \
		EMACS=no \
		|| die "econf failed"
	emake || die "emake failed"

	if use emacs; then
		elisp-compile elisp/cflow-mode.el || die
	fi
}

src_install() {
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
	doinfo doc/cflow.info
	emake DESTDIR="${D}" install || die "emake install failed"

	if use emacs; then
		elisp-install ${PN} elisp/cflow-mode.{el,elc} || die
		elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
