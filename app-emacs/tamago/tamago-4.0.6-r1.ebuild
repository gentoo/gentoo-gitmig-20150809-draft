# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/tamago/tamago-4.0.6-r1.ebuild,v 1.15 2010/09/24 18:51:51 ulm Exp $

inherit elisp eutils

TAMAGO_CANNA="canna-20011204.diff"

DESCRIPTION="Emacs Backend for Sj3 Ver.2, FreeWnn, Wnn6 and Canna"
HOMEPAGE="http://www.m17n.org/tamago/index.en.html"
SRC_URI="ftp://ftp.m17n.org/pub/tamago/${P}.tar.gz
	http://cgi18.plala.or.jp/nyy/canna/${TAMAGO_CANNA}.gz
	mirror://gentoo/${P}-canna-gentoo.patch.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ppc ppc64 sparc x86"
IUSE="canna"

DEPEND="app-arch/gzip
	>=sys-apps/sed-4"
RDEPEND="canna? ( app-i18n/canna )"

SITEFILE=50${PN}-gentoo.el

src_unpack() {
	unpack ${A}

	epatch ${P}-canna-gentoo.patch
	epatch ${TAMAGO_CANNA}
}

src_compile() {
	./configure --prefix=/usr || die
	emake || die
}

src_install() {
	dodir ${SITELISP}/${PN}
	emake prefix="${D}"/usr \
		infodir="${D}"/usr/share/info \
		elispdir="${D}"/${SITELISP}/${PN} \
		etcdir="${D}"/usr/share/${PN}  install || die

	if use canna; then
		cat >${SITEFILE} <<-EOF
		(set-language-info "Japanese" 'input-method "japanese-egg-canna")
		EOF
		elisp-site-file-install ${SITEFILE} || die
	fi

	dodoc README.ja.txt AUTHORS PROBLEMS TODO ChangeLog
}

pkg_postinst() {
	elisp-site-regen

	if ! grep -q inet "${ROOT}"/etc/conf.d/canna && use canna ; then
		sed -i -e '/CANNASERVER_OPTS/s/"\(.*\)"/"\1 -inet"/' \
			"${ROOT}"/etc/conf.d/canna

		ewarn
		ewarn "Enabled inet domain socket for tamago."
		ewarn "You must restart cannaserver in order to use."
		ewarn "Beware of increasing security risks."
		ewarn
	fi
}
