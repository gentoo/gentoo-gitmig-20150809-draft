# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/aspectj4emacs/aspectj4emacs-1.1_beta2.ebuild,v 1.10 2007/10/07 18:23:00 opfer Exp $

inherit elisp eutils

MY_P="AspectJForEmacs-${PV/_beta/b}"

DESCRIPTION="AspectJ support for GNU Emacs java-mode and JDEE"
HOMEPAGE="http://aspectj4emacs.sourceforge.net/"
SRC_URI="http://aspectj4emacs.sourceforge.net/${MY_P}.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE=""

RDEPEND="app-emacs/jde
	=dev-java/aspectj-1*"
DEPEND="${RDEPEND}
	app-arch/unzip"


S="${WORKDIR}/${MY_P}"

SITEFILE=80${PN}-gentoo.el

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/${PF}-compile-log-gentoo.patch"
	epatch "${FILESDIR}/${PF}-browse-url-new-window-gentoo.patch"
	cd "${S}"
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
		doins $(find ${subdir} -type f ! -name \*.el)
		dosym /usr/share/doc/${PF}/html/${subdir}.html \
			/usr/share/emacs/site-lisp/${PN}/${subdir}.html
	done
	dohtml *.html *.gif
}
