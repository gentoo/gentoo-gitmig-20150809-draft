# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/gnus-cvs/gnus-cvs-5.10.3.ebuild,v 1.2 2003/12/30 06:38:08 jbms Exp $

ECVS_SERVER="cvs.gnus.org:/usr/local/cvsroot"
ECVS_MODULE="gnus"
ECVS_USER="gnus"
ECVS_PASS="gnus"
ECVS_CVS_OPTIONS="-dP"

inherit elisp cvs

IUSE="emacs-w3"

S=${WORKDIR}/${ECVS_MODULE}
DESCRIPTION="Current alpha branch of the Gnus news- and mail-reader"
HOMEPAGE="http://www.gnus.org/"
SRC_URI=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha ~sparc"

# Never use the sandbox, it causes Emacs to segfault on startup
SANDBOX_DISABLED="1"
RESTRICT="$RESTRICT nostrip"

DEPEND="virtual/emacs
emacs-w3? app-emacs/w3"

src_compile() {
	local myconf
	if [ $(use emacs-w3) ]; then
		myconf="${myconf} --with-w3=/usr/share/emacs/site-lisp/w3"
		myconf="${myconf} --with-url=/usr/share/emacs/site-lisp/w3"
	else
		myconf="${myconf} --without-w3 --without-url"
	fi
	econf \
		--with-emacs \
		--with-lispdir=/usr/share/emacs/site-lisp/gnus-cvs \
		--with-etcdir=/usr/share/emacs/etc \
		${myconf}
	emake || die
}

src_install() {
	einstall \
		lispdir=${D}/usr/share/emacs/site-lisp/gnus-cvs \
		etcdir=${D}/usr/share/emacs/etc \
		|| die

	elisp-site-file-install ${FILESDIR}/70${PN}-gentoo.el

	dodoc ChangeLog GNUS-NEWS README todo

	# fix info documentation
	find ${D}/usr/share/info -type f -exec mv {} {}.info \;
}
