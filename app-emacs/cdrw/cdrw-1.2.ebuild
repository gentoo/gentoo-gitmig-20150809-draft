# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/cdrw/cdrw-1.2.ebuild,v 1.8 2005/07/01 18:14:57 mkennedy Exp $

inherit elisp

IUSE=""

DESCRIPTION="Emacs dired frontend to various commandline CDROM burning tools"
HOMEPAGE="ftp://ftp.cis.ohio-state.edu/pub/emacs-lisp/archive/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"

DEPEND="virtual/emacs"
RDEPEND="${DEPEND}
	dev-perl/MP3-Info
	media-sound/mpg321
	app-cdr/cdrtools"

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

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
	exeinto /usr/bin
	doexe  mp3time
}
