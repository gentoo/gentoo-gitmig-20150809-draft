# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/gambit/gambit-4.0_beta15.ebuild,v 1.2 2006/10/10 08:29:07 joslwah Exp $

inherit eutils elisp-common

MY_PN=gambc

MY_PV=${PV//_beta/b}
MY_PV=${MY_PV/./}

DESCRIPTION="Gambit-C is a native Scheme to C compiler and interpreter."
HOMEPAGE="http://www.iro.umontreal.ca/~gambit/"
SRC_URI="http://www.iro.umontreal.ca/~feeley/${MY_PN}${MY_PV}.tar.gz"

LICENSE="Apache-2.0 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE="emacs"

DEPEND="emacs? ( virtual/emacs )"

SITEFILE="50gambit-gentoo.el"

S=${WORKDIR}/${MY_PN}${MY_PV}

src_compile() {
	econf --enable-shared --enable-single-host || die
	emake || die "emake failed"
	if use emacs; then
		( cd misc; elisp-comp *.el )
	fi
}

src_install() {
	einstall docdir=${D}/usr/share/doc/${P} || die
	rm -rf ${D}/usr/share/emacs
	if use emacs; then
		elisp-install ${PN} misc/*.{el,elc}
		elisp-site-file-install ${FILESDIR}/${SITEFILE}
	fi

	mv ${D}/usr/syntax-case.scm ${D}/usr/share/doc/${P}/
	# rename the /usr/bin/gsc to avoid collision with gsc from ghostscript
	mv ${D}/usr/bin/gsc ${D}/usr/bin/gsc-gambit
	dodoc INSTALL.txt LICENSE-2.0.txt README
	insinto /usr/share/doc/${PF}
	doins -r examples
	find ${D}/usr/share/doc/${PF}/examples -type f \
		\( -name makefile -o -name makefile.in \) \
		-exec rm -f '{}' \;
}
