# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/tamago/tamago-4.0.6-r1.ebuild,v 1.8 2004/07/30 18:46:22 usata Exp $

inherit elisp eutils

TAMAGO_CANNA="canna-20011204.diff"

DESCRIPTION="Emacs Backend for Sj3 Ver.2, FreeWnn, Wnn6 and Canna"
HOMEPAGE="http://www.m17n.org/tamago/"
SRC_URI="ftp://ftp.m17n.org/pub/tamago/${P}.tar.gz
	http://cgi18.plala.or.jp/nyy/canna/${TAMAGO_CANNA}.gz
	mirror://gentoo/${P}-canna-gentoo.patch.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha ppc64"
IUSE="canna"

DEPEND="virtual/emacs
	app-arch/gzip
	>=sys-apps/sed-4"
RDEPEND="virtual/emacs
	canna? ( app-i18n/canna )"

SITEFILE=50tamago-gentoo.el

src_unpack() {
	unpack ${P}.tar.gz
	unpack ${TAMAGO_CANNA}.gz

	epatch ${DISTDIR}/${P}-canna-gentoo.patch.gz
	epatch ${TAMAGO_CANNA}
}

src_compile() {
	./configure --prefix=/usr || die
	emake || die
}

src_install() {
	dodir ${SITELISP}/${PN}
	emake prefix=${D}/usr \
		infodir=${D}/usr/share/info \
		elispdir=${D}/${SITELISP}/${PN} \
		etcdir=${D}/usr/share/${PN}  install || die


	cp ${FILESDIR}/${SITEFILE} ${SITEFILE}
	if use canna ; then
		cat >>${SITEFILE}<<-EOF
		(set-language-info "Japanese" 'input-method "japanese-egg-canna")

		EOF
	fi

	elisp-site-file-install ${SITEFILE} || die

	dodoc README.ja.txt AUTHORS PROBLEMS TODO ChangeLog
}

pkg_postinst() {
	elisp-site-regen

	if ! grep -q inet ${ROOT}/etc/conf.d/canna && use canna ; then
		sed -i -e '/CANNASERVER_OPTS/s/"\(.*\)"/"\1 -inet"/' \
			${ROOT}/etc/conf.d/canna

		einfo
		einfo "Enabled inet domain socket for tamago."
		einfo "You must restart cannaserver in order to use."
		einfo "Beware of increasing security risks."
		einfo
	fi
}
