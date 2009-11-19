# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/gnus/gnus-9999.ebuild,v 1.1 2009/11/19 07:16:26 ulm Exp $

ECVS_SERVER="cvs.gnus.org:/usr/local/cvsroot"
ECVS_MODULE="gnus"
ECVS_USER="gnus"
ECVS_PASS="gnus"
ECVS_CVS_OPTIONS="-dP"

inherit elisp cvs

DESCRIPTION="The Gnus newsreader and mail-reader"
HOMEPAGE="http://gnus.org/"
SRC_URI=""

LICENSE="GPL-3 FDL-1.2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="!app-emacs/gnus-cvs
	!app-emacs/ngnus"

S="${WORKDIR}/${ECVS_MODULE}"
SITEFILE="70${PN}-gentoo.el"

src_compile() {
	econf \
		--with-emacs --without-w3 --without-url \
		--with-lispdir=${SITELISP}/${PN} \
		--with-etcdir=${SITEETC}/${PN}
	emake || die "emake failed"
}

src_install() {
	einstall \
		lispdir="${D}${SITELISP}/${PN}" \
		etcdir="${D}${SITEETC}/${PN}" \
		|| die "einstall failed"

	# fix info documentation
	for i in "${D}"/usr/share/info/*; do
		mv "${i}" "${i}".info || die "mv info failed"
	done

	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die

	dodoc ChangeLog GNUS-NEWS README todo || die "dodoc failed"
}
