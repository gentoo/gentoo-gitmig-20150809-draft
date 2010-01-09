# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xdvik/xdvik-22.84.16.ebuild,v 1.2 2010/01/09 13:22:12 aballier Exp $

inherit eutils flag-o-matic elisp-common toolchain-funcs

DESCRIPTION="DVI previewer for X Window System"
HOMEPAGE="http://xdvi.sourceforge.net/"
SRC_URI="mirror://sourceforge/xdvi/${P}.tar.gz"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
SLOT="0"
LICENSE="GPL-2"
IUSE="motif neXt Xaw3d emacs"

RDEPEND=">=media-libs/t1lib-5.0.2
	x11-libs/libXmu
	x11-libs/libXp
	x11-libs/libXpm
	motif? ( x11-libs/openmotif )
	!motif? ( neXt? ( x11-libs/neXtaw )
		!neXt? ( Xaw3d? ( x11-libs/Xaw3d ) ) )
	virtual/latex-base
	!<app-text/texlive-2007"
DEPEND="${RDEPEND}"
TEXMF_PATH=/usr/share/texmf
S=${WORKDIR}/${P}/texk/xdvik

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-open-mode.patch"
	epatch "${FILESDIR}/${P}-cvararg.patch"
	# Make sure system kpathsea headers are used
	cd "${WORKDIR}/${P}/texk/kpathsea"
	for i in *.h ; do echo "#include_next \"$i\"" > $i; done
}

src_compile() {
	cd "${WORKDIR}/${P}"

	tc-export CC AR RANLIB

	local toolkit

	if use motif ; then
		toolkit="motif"
	elif use neXt ; then
		toolkit="neXtaw"
	elif use Xaw3d ; then
		toolkit="xaw3d"
	else
		toolkit="xaw"
	fi

	econf --disable-multiplatform \
		--enable-t1lib \
		--enable-gf \
		--with-system-t1lib \
		--with-system-kpathsea \
		--with-kpathsea-include=/usr/include/kpathsea \
		--with-xdvi-x-toolkit="${toolkit}"

	cd "${S}"
	emake kpathsea_dir="/usr/include/kpathsea" texmf="${TEXMF_PATH}" || die
	use emacs && elisp-compile xdvi-search.el
}

src_install() {
	einstall kpathsea_dir="/usr/include/kpathsea" texmf="${D}${TEXMF_PATH}" || die "install failed"

	dodir /etc/texmf/xdvi /etc/X11/app-defaults
	mv "${D}${TEXMF_PATH}/xdvi/XDvi" "${D}etc/X11/app-defaults" || die "failed to move config file"
	dosym {/etc/X11/app-defaults,"${TEXMF_PATH}/xdvi"}/XDvi || die "failed to symlink config file"
	for i in $(find "${D}${TEXMF_PATH}/xdvi" -type f -maxdepth 1) ; do
		mv ${i} "${D}etc/texmf/xdvi" || die "failed to move $i"
		dosym {/etc/texmf,"${TEXMF_PATH}"}/xdvi/$(basename ${i}) || die "failed	to symlink $i"
	done

	dodoc BUGS FAQ README.* || die "dodoc failed"

	use emacs && elisp-install tex-utils *.el *.elc

	doicon "${FILESDIR}/${PN}.png"
	make_desktop_entry xdvi "XDVI" xdvik "Graphics;Viewer"
	echo "MimeType=application/x-dvi;" >> "${D}"usr/share/applications/xdvi-"${PN}".desktop
}

pkg_postinst() {
	if use emacs; then
		elog "Add"
		elog "	(add-to-list 'load-path \"${SITELISP}/tex-utils\")"
		elog "	(require 'xdvi-search)"
		elog "to your ~/.emacs file"
	fi
}
