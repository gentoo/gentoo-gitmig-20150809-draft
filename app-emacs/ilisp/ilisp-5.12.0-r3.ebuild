# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/ilisp/ilisp-5.12.0-r3.ebuild,v 1.9 2004/11/03 07:50:16 usata Exp $

inherit elisp

# good idea to be very compatible with Debian since this is what users
# will expect in Gentoo (Debian is the only other distribution which
# supports Emacs and Common Lisp well)

DEBCVS=cvs.2003.07.20

DESCRIPTION="A comprehensive Emacs interface for an inferior Common Lisp, or other Lisp based languages."
HOMEPAGE="http://sourceforge.net/projects/ilisp/"
SRC_URI="mirror://debian/pool/main/i/ilisp/${P/-/_}+${DEBCVS}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-lisp/common-lisp-controller
	sys-apps/texinfo
	virtual/tetex
	app-text/texi2html"


S="${WORKDIR}/${P}+${DEBCVS}"

CLPACKAGE=ilisp

src_compile() {
	make EMACS=emacs SHELL=/bin/sh || die
	cd extra
	elisp-comp *.el || die "elisp-comp failed"
	cd -
	make -C ${S}/docs || die "make docs failed"
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-install ${PN}/extra extra/*.el extra/*.elc

	insinto /etc/ilisp
	doins debian/ilisp*.el

	insinto /usr/share/common-lisp/source/ilisp
	doins *.lisp debian/ilisp.asd
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

	elisp-site-file-install ${FILESDIR}/50ilispclc-gentoo.el
	dodoc ACKNOWLEDGMENTS GETTING-ILISP HISTORY INSTALLATION README Welcome

	dosed "s,@HYPERSPEC@,${P}/HyperSpec,g" /usr/share/emacs/site-lisp/50ilispclc-gentoo.el
}

pkg_preinst() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}

pkg_postinst() {
	elisp-site-regen
	chown -R cl-builder:cl-builder /usr/lib/ilisp
	/usr/sbin/register-common-lisp-source ${PN}
	clc-autobuild-library ilisp yes
}

pkg_postrm() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
	elisp-site-regen
}
