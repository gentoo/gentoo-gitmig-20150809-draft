# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-misc/gri/gri-2.12.17.ebuild,v 1.2 2008/08/24 17:29:46 ulm Exp $

inherit eutils elisp-common

DESCRIPTION="language for scientific graphics programming"
HOMEPAGE="http://gri.sourceforge.net/"
SRC_URI="mirror://sourceforge/gri/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc emacs examples"
RESTRICT="test"

DEPEND=">=sci-libs/netcdf-3.5.0
	virtual/latex-base
	media-gfx/imagemagick
	virtual/ghostscript
	emacs? ( virtual/emacs )"

SITEFILE="50gri-gentoo.el"

src_compile() {
	econf || die "econf failed."
	emake || die "emake failed."
	if use emacs; then
		elisp-compile src/*.el || die "elisp-compile failed"
	fi
}

src_install() {
	# Replace PREFIX now and correct paths in the startup message.
	sed -e s,PREFIX/share/gri/doc/,/usr/share/doc/${P}/, -i "${S}/src/startup.msg"

	einstall || die "einstall failed."

	# license text not necessary
	rm "${D}"/usr/share/gri/doc/license.txt

	# install target installs it always and in the wrong location
	# remove it here and call elisp-install in case of USE=emacs below
	rm -rf "${D}"/usr/share/emacs

	if ! use doc; then
		sed -e "s/Manual at.*//" -i "${D}"/usr/share/gri/startup.msg
		rm "${D}"/usr/share/gri/doc/cmdrefcard.ps
		rm "${D}"/usr/share/gri/doc/refcard.ps
		rm -rf "${D}"/usr/share/gri/doc/html
	fi
	if ! use examples; then
		sed -e "s/Examples at.*//" -i "${D}"/usr/share/gri/startup.msg
		rm -rf "${D}"/usr/share/gri/doc/examples
	fi

	dodoc README

	#move docs to the proper place
	mv "${D}"/usr/share/gri/doc/* "${D}/usr/share/doc/${PF}"
	rmdir "${D}/usr/share/gri/doc/"

	if use emacs; then
		cd src
		elisp-install ${PN} *.{el,elc} || die "elisp-install failed"
		elisp-site-file-install "${FILESDIR}/${SITEFILE}" \
			|| die "elisp-site-file-install failed"
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
