# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/yc/yc-4.0.3.ebuild,v 1.2 2003/12/24 05:15:01 usata Exp $

inherit elisp

IUSE=""

DESCRIPTION="YC - Yet another Canna client on Emacsen."
HOMEPAGE="http://www.ceres.dti.ne.jp/~knak/yc.html"
SRC_URI="http://www.ceres.dti.ne.jp/~knak/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86 alpha"

DEPEND="virtual/emacs
	>=app-i18n/canna-3.6"

S="${WORKDIR}/${P}"
SITEFILE="50yc-gentoo.el"

src_compile() {
	emake || die
}

src_install() {
	elisp-install ${PN} *.el *.elc || die
	elisp-site-file-install ${FILESDIR}/${SITEFILE} || die
	dobin icanna || die
	newdoc ${FILESDIR}/sample.dot.emacs-4 sample.dot.emacs || die
	dodoc ${FILESDIR}/sample.hosts.canna || die
}

pkg_postinst() {
	elisp-site-regen
	einfo "See /usr/share/doc/${P}/sample.dot.emacs.gz."
	einfo ""
	einfo "And If you use unix domain socket for connecting the canna server, "
	einfo "  please confirm that there's *no* following line in your .emacs ."
	einfo "  (setq yc-server-host \"localhost\")"
	einfo ""
	einfo "If you use inet domain socket for connecting the canna server, "
	einfo "  please modify as following in /etc/conf.d/canna."
	einfo "  CANNASERVER_OPTS=\"-inet\""
	einfo "  And create /etc/hosts.canna."
	einfo "  (sample is /usr/share/doc/${P}/sample.hosts.canna.gz)"
}

pkg_postrm() {
	elisp-site-regen
}
