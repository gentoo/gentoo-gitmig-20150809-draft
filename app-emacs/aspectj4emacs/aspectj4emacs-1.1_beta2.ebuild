# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/aspectj4emacs/aspectj4emacs-1.1_beta2.ebuild,v 1.6 2004/11/03 05:33:39 usata Exp $

inherit elisp eutils

IUSE=""

MY_P="AspectJForEmacs-${PV/_beta/b}"

DESCRIPTION="AspectJ support for GNU Emacs java-mode and JDEE"
HOMEPAGE="http://aspectj4emacs.sourceforge.net/"
SRC_URI="http://aspectj4emacs.sourceforge.net/${MY_P}.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

RDEPEND="app-emacs/jde
	=dev-java/aspectj-1.1*"
DEPEND="${RDEPEND}
	app-arch/unzip
	>=sys-apps/sed-4"

S="${WORKDIR}/${MY_P}"

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
