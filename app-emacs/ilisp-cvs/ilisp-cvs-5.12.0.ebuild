# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/ilisp-cvs/ilisp-cvs-5.12.0.ebuild,v 1.1 2004/01/17 20:58:19 mkennedy Exp $

ECVS_SERVER="cvs-pserver.sourceforge.net:80/cvsroot/ilisp"
ECVS_MODULE="ILISP"
ECVS_USER="anonymous"
ECVS_CVS_OPTIONS="-dP"

inherit elisp-common cvs

DESCRIPTION="A comprehensive Emacs interface for an inferior Common Lisp, or other Lisp based languages."
HOMEPAGE="http://sourceforge.net/projects/ilisp/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

DEPEND="virtual/emacs
	dev-lisp/common-lisp-controller
	doc? ( virtual/tetex sys-apps/texinfo app-text/texi2html )"


S=${WORKDIR}/ILISP

CLPACKAGE=ilisp

src_compile() {
	make EMACS=emacs SHELL=/bin/sh || die
	cd extra && for i in *.el ; do
		elisp-comp *.el
	done
	use doc && make -C ${S}/docs
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-install ${PN}/extra extra/*.el extra/*.elc

	insinto /etc/ilisp
	doins ${FILESDIR}/ilisp.el ${FILESDIR}/ilisp-keybindings.el

	insinto /usr/share/common-lisp/source/ilisp
	doins *.lisp ${FILESDIR}/ilisp.asd
	dodir /usr/share/common-lisp/systems
	dosym /usr/share/common-lisp/source/ilisp/ilisp.asd /usr/share/common-lisp/systems/ilisp.asd

	dodir /usr/lib/ilisp
	for i in ${D}/usr/share/common-lisp/source/ilisp/*.lisp ; do
		l=`basename $i`
		dosym /usr/share/common-lisp/source/ilisp/$l /usr/lib/ilisp/$l
	done

	insinto /usr/share/${PN}
	doins *.scm

	doinfo docs/*.info*
	dohtml docs/*.html
	dodoc docs/*.ps

	elisp-site-file-install ${FILESDIR}/60ilisp-cvs-gentoo.el
	dodoc ACKNOWLEDGMENTS COPYING GETTING-ILISP HISTORY INSTALLATION README Welcome
}

pkg_preinst() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}

pkg_postinst() {
	elisp-site-regen
	chown -R cl-builder:cl-builder /usr/lib/ilisp
	/usr/sbin/register-common-lisp-source ${CLPACKAGE}
	clc-autobuild-library ilisp yes
}

pkg_postrm() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
	elisp-site-regen
}
