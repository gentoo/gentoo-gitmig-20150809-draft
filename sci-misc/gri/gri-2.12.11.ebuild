# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-misc/gri/gri-2.12.11.ebuild,v 1.1 2006/05/19 19:39:27 mkennedy Exp $

inherit eutils elisp-common

IUSE="emacs"

DESCRIPTION="language for scientific graphics programming"
HOMEPAGE="http://gri.sourceforge.net/"
SRC_URI="mirror://sourceforge/gri/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND=">=sci-libs/netcdf-3.5.0
	virtual/tetex
	media-gfx/imagemagick
	emacs? ( virtual/emacs )
	virtual/ghostscript"

SITEFILE="50gri-gentoo.el"

src_compile() {
	econf || die "econf failed."
	emake || die "emake failed."
	if use emacs; then
		pushd src; elisp-comp *.el; popd
	fi
}

src_install() {
	# Replace PREFIX now and correct paths in the startup message.
	sed -e s,PREFIX/share/doc/gri/,/usr/share/doc/${P}/, -i ${S}/startup.msg

	einstall || die "einstall failed."

	dodoc AUTHOR README
	#move docs to the proper place
	mv ${D}/usr/share/gri/doc/* ${D}/usr/share/doc/${PF}
	rmdir ${D}/usr/share/gri/doc/

	if use emacs; then
		pushd src
		elisp-install gri *.{el,elc}
		elisp-site-file-install ${FILESDIR}/${SITEFILE}
		popd
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
