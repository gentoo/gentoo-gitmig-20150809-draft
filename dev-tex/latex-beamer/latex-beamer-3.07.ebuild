# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/latex-beamer/latex-beamer-3.07.ebuild,v 1.29 2010/12/09 16:48:04 aballier Exp $

inherit latex-package

DESCRIPTION="LaTeX class for creating presentations using a video projector."
HOMEPAGE="http://bitbucket.org/rivanvx/beamer/wiki/Home"
SRC_URI="mirror://sourceforge/latex-beamer/${P}.tar.gz"

LICENSE="GPL-2 FDL-1.2 LPPL-1.3c"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"

IUSE="doc examples lyx"

DEPEND="lyx? ( app-office/lyx )
	dev-texlive/texlive-latex
	!>=dev-texlive/texlive-latex-2010"
RDEPEND=">=dev-tex/pgf-1.10"

src_install() {
	insinto /usr/share/texmf-site/tex/latex/beamer
	doins -r base extensions themes || die "could not install themes"

	insinto /usr/share/texmf-site/tex/latex/beamer/emulation
	doins emulation/*.sty || die "could not install styles"

	if use lyx ; then
		insinto /usr/share/lyx/examples
		doins examples/lyx-based-presentation/* || \
			die "could not install lyx-examples"
	fi

	dodoc AUTHORS ChangeLog README TODO doc/licenses/LICENSE

	if use doc ; then
		insinto /usr/share/doc/${PF}/doc
		doins doc/* || die "could not install doc"
	fi

	if use examples ; then
		rm -f "${S}"/examples/a-lecture/{*.tex~,._beamerexample-lecture-pic*}
		if ! use lyx ; then
			einfo "Removing lyx examples as lyx useflag is not set"
			find "${S}" -name "*.lyx" -print -delete
		fi
		insinto /usr/share/doc/${PF}
		doins -r examples emulation/examples solutions || \
			die "could not install examples"
	fi
}
