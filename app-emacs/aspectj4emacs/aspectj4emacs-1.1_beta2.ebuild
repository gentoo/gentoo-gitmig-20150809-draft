# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/aspectj4emacs/aspectj4emacs-1.1_beta2.ebuild,v 1.5 2004/07/16 09:21:12 dholm Exp $

inherit elisp eutils

IUSE=""

MYPV="1.1b2"

DESCRIPTION="AspectJ support for GNU Emacs java-mode and JDEE"
HOMEPAGE="http://aspectj4emacs.sourceforge.net/"
SRC_URI="http://aspectj4emacs.sourceforge.net/AspectJForEmacs-${MYPV}.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

DEPEND="virtual/emacs
	app-emacs/jde
	=dev-java/aspectj-1.1*"

S="${WORKDIR}/AspectJForEmacs-${MYPV}"

SITEFILE=80aspectj4emacs-gentoo.el

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PF}-compile-log-gentoo.patch
	epatch ${FILESDIR}/${PF}-browse-url-new-window-gentoo.patch
	cd ${S}
	cp */*.el .
	sed -i "s,@build.version.short@,${PV},g" *.el
}

src_compile() {
	elisp-comp *.el || die
}

src_install() {
	elisp_src_install
	for subdir in ajdee aspectj-mode; do
		insinto /usr/share/doc/${PF}/${subdir}
		doins `find ${subdir} -type f ! -name \*.el`
		dosym /usr/share/doc/${PF}/html/${subdir}.html \
			/usr/share/emacs/site-lisp/${PN}/${subdir}.html
	done
	dohtml *.html *.gif
}
