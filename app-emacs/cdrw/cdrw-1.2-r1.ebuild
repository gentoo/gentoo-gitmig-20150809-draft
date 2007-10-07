# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/cdrw/cdrw-1.2-r1.ebuild,v 1.2 2007/10/07 20:50:34 ulm Exp $

inherit elisp

DESCRIPTION="Emacs dired frontend to various commandline CDROM burning tools"
HOMEPAGE="ftp://ftp.cis.ohio-state.edu/pub/emacs-lisp/archive/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	dev-perl/MP3-Info
	media-sound/mpg321
	virtual/cdrtools"

SITEFILE=50cdrw-gentoo.el

src_unpack() {
	unpack ${A}
	cd "${S}"
	# extract mp3time script
	sed -ne '641,694 {p;}' <cdrw.el |sed -e 's/^;\ //' >mp3time && \
		chmod +x mp3time || die
	# no reason to use non-free software
	cp cdrw.el cdrw.el~ && sed -e 's/mpg123/mpg321/g' <cdrw.el~ >cdrw.el
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	exeinto /usr/bin
	doexe  mp3time
}
