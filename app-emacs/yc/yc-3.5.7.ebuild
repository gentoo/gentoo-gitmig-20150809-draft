# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/yc/yc-3.5.7.ebuild,v 1.2 2003/05/17 19:51:17 nakano Exp $

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

S="${WORKDIR}/${P}"
SITEFILE="50yc-gentoo.el"

src_unpack() {
	mkdir -p ${S}
	gzip -dc ${DISTDIR}/${MY_P}.gz > ${S}/yc.el
}

src_compile() {
	emacs -batch -eval '(byte-compile-file "yc.el")'
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}

	dodoc ${FILESDIR}/sample*
}

pkg_postinst() {
	einfo "Please modify as following in /etc/conf.d/canna."
	einfo "\n\t CANNASERVER_OPTS=\"-inet\"\n"
	einfo "And create /etc/hosts.canna."
	einfo "(sample is /usr/share/doc/${P}/sample.hosts.canna.gz)"
	einfo "And see /usr/share/doc/${P}/sample.dot.emacs.gz."
	elisp-site-regen
}

pkg_postrm() {
	elisp-site-regen
}
