# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/cdrw/cdrw-1.2.ebuild,v 1.3 2003/09/06 22:01:25 msterret Exp $

inherit elisp

IUSE=""

DESCRIPTION="Emacs dired frontend to various commandline CDROM burning tools"
HOMEPAGE="ftp://ftp.cis.ohio-state.edu/pub/emacs-lisp/archive/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/emacs"
RDEPEND="${DEPEND}
	dev-perl/MP3-Info
	media-sound/mpg321
	app-cdr/cdrtools"

S="${WORKDIR}/${P}"

SITEFILE=50cdrw-gentoo.el

src_unpack() {
	unpack ${A}
	cd ${S}
	# extract mp3time script
	sed -ne '641,694 {p;}' <cdrw.el |sed -e 's/^;\ //' >mp3time && \
		chmod +x mp3time || die
	# no reason to use non-free software
	cp cdrw.el cdrw.el~ && sed -e 's/mpg123/mpg321/g' <cdrw.el~ >cdrw.el
}

src_compile() {
	emacs --batch -f batch-byte-compile --no-site-file --no-init-file *.el || die
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}

	exeinto /usr/bin
	doexe  mp3time
}

pkg_postinst() {
	elisp-site-regen
	einfo "Please see ${SITELISP}/${PN}/cdrw.el for the complete documentation."
}

pkg_postrm() {
	elisp-site-regen
}
