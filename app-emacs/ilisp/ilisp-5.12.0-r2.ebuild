# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/ilisp/ilisp-5.12.0-r2.ebuild,v 1.1 2003/06/11 19:44:29 mkennedy Exp $

inherit elisp

# good idea to be very compatible with Debian since this is what users
# will expect in Gentoo (Debian is the only other distribution which
# supports Emacs and Common Lisp well)

DEBCVS=cvs.2003.06.05

DESCRIPTION="A comprehensive Emacs interface for an inferior Common Lisp, or other Lisp based languages."
HOMEPAGE="http://sourceforge.net/projects/ilisp/"
SRC_URI="http://ftp.debian.org/debian/pool/main/i/ilisp/${PN}_${PV}+${DEBCVS}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/emacs
	dev-lisp/common-lisp-controller
	app-text/texi2html"

S="${WORKDIR}/${P}+${DEBCVS}"

src_compile() {
	make EMACS=emacs SHELL=/bin/sh || die
	cd extra && for i in *.el ; do 
		emacs --batch --no-site-file --eval "(byte-compile-file \"$i\")" *.el
	done
	make -C ${S}/docs info ilisp.html
}

src_install() {
	insinto /usr/share/emacs/site-lisp/ilisp
	doins *.el *.elc
	insinto /usr/share/emacs/site-lisp/ilisp/extra
	doins extra/*.el extra/*.elc

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

 	insinto /usr/share/emacs/site-lisp
	doins ${FILESDIR}/50ilispclc-gentoo.el
 	dodoc ACKNOWLEDGMENTS COPYING GETTING-ILISP HISTORY INSTALLATION README Welcome 
}

pkg_postinst() {
	elisp-site-regen
	chown -R cl-builder.cl-builder /usr/lib/ilisp
	/usr/sbin/register-common-lisp-source ${PN}
	clc-autobuild-library ilisp yes
	
}

pkg_postrm() {
	/usr/sbin/unregister-common-lisp-source ${PN}
	elisp-site-regen
}
