# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/yc/yc-3.5.8.ebuild,v 1.6 2004/02/24 08:58:30 mr_bones_ Exp $

inherit elisp

IUSE=""

MY_P=yc.el-${PV}
DESCRIPTION="YC - Yet another Canna client on Emacsen."
HOMEPAGE="http://www.ceres.dti.ne.jp/~knak/yc.html"
SRC_URI="http://www.ceres.dti.ne.jp/~knak/${MY_P}.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/emacs
	>=app-i18n/canna-3.6"

SITEFILE="50yc-gentoo.el"
S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	mv ${MY_P} yc.el || die
}

src_compile() {
	elisp-compile yc.el || die
}

src_install() {
	elisp-install ${PN} *.el *.elc || die
	elisp-site-file-install ${FILESDIR}/${SITEFILE} || die
	dodoc ${FILESDIR}/sample.dot.emacs ${FILESDIR}/sample.hosts.canna || die
}

pkg_postinst() {
	elisp-site-regen
	einfo "Please modify as following in /etc/conf.d/canna."
	einfo
	einfo "\t CANNASERVER_OPTS=\"-inet\""
	einfo
	einfo "And create /etc/hosts.canna."
	einfo "(sample is /usr/share/doc/${P}/sample.hosts.canna.gz)"
	einfo "And see /usr/share/doc/${P}/sample.dot.emacs.gz."
}

pkg_postrm() {
	elisp-site-regen
}
