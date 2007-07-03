# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/gnus-cvs/gnus-cvs-5.11.ebuild,v 1.15 2007/07/03 06:14:40 ulm Exp $

ECVS_SERVER="cvs.gnus.org:/usr/local/cvsroot"
ECVS_MODULE="gnus"
ECVS_USER="gnus"
ECVS_PASS="gnus"
ECVS_CVS_OPTIONS="-dP"

inherit elisp cvs

DESCRIPTION="Current alpha branch of the Gnus news- and mail-reader"
HOMEPAGE="http://www.gnus.org/"
SRC_URI=""

LICENSE="GPL-2 FDL-1.2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha ~sparc ~amd64"
IUSE=""
RESTRICT="strip"

RDEPEND=""
RDEPEND="!app-emacs/gnus"

S=${WORKDIR}/${ECVS_MODULE}
SITEFILE=70${PN}-gentoo.el

src_compile() {
	local myconf
	myconf="${myconf} --without-w3 --without-url"
	econf \
		--with-emacs \
		--with-lispdir=/usr/share/emacs/site-lisp/gnus-cvs \
		--with-etcdir=/usr/share/emacs/etc \
		${myconf} || die "econf failed"
	# bug #75325
	emake -j1 || die
}

src_install() {
	einstall \
		lispdir="${D}/usr/share/emacs/site-lisp/gnus-cvs" \
		etcdir="${D}/usr/share/emacs/etc" \
		|| die "einstall failed"

	elisp-site-file-install "${FILESDIR}/${SITEFILE}"

	dodoc ChangeLog GNUS-NEWS README todo

	# fix info documentation
	find "${D}/usr/share/info" -type f -exec mv {} {}.info \;
}
