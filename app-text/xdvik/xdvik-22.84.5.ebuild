# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xdvik/xdvik-22.84.5.ebuild,v 1.1 2004/11/19 11:50:03 usata Exp $

inherit eutils flag-o-matic elisp-common

IUSE="cjk libwww lesstif motif neXt  Xaw3d emacs"

XDVIK_JP="${P}-20041106-jp"

DESCRIPTION="DVI previewer for X Window System"
SRC_URI="mirror://sourceforge/xdvi/${P}.tar.gz
	cjk? ( mirror://sourceforge.jp/xdvi/12134/${XDVIK_JP}.diff.gz )"
HOMEPAGE="http://sourceforge.net/projects/xdvi/
	http://xdvi.sourceforge.jp/"

KEYWORDS="~x86 ~alpha ~ppc ~sparc ~amd64 ~ppc64 ~ppc-macos"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-libs/t1lib-5.0.2
	virtual/x11
	motif? ( lesstif? ( x11-libs/lesstif )
		!lesstif? ( x11-libs/openmotif ) )
	!motif? ( neXt? ( x11-libs/neXtaw )
		!neXt? ( Xaw3d? ( x11-libs/Xaw3d ) ) )
	libwww? ( >=net-libs/libwww-5.3.2-r1 )
	cjk? ( app-text/ptex
		>=media-libs/freetype-2
		>=media-fonts/kochi-substitute-20030809-r3 )
	!cjk? ( virtual/tetex )"

src_unpack () {

	unpack ${P}.tar.gz
	if use cjk ; then
		epatch ${DISTDIR}/${XDVIK_JP}.diff.gz
		cat >>${S}/texk/xdvik/vfontmap.sample<<-EOF

		# TrueType fonts
		min     /usr/share/fonts/kochi-substitute/kochi-mincho-subst.ttf
		nmin    /usr/share/fonts/kochi-substitute/kochi-mincho-subst.ttf
		goth    /usr/share/fonts/kochi-substitute/kochi-gothic-subst.ttf
		tmin    /usr/share/fonts/kochi-substitute/kochi-mincho-subst.ttf
		tgoth   /usr/share/fonts/kochi-substitute/kochi-gothic-subst.ttf
		ngoth   /usr/share/fonts/kochi-substitute/kochi-gothic-subst.ttf
		jis     /usr/share/fonts/kochi-substitute/kochi-mincho-subst.ttf
		jisg    /usr/share/fonts/kochi-substitute/kochi-gothic-subst.ttf
		dm      /usr/share/fonts/kochi-substitute/kochi-mincho-subst.ttf
		dg      /usr/share/fonts/kochi-substitute/kochi-gothic-subst.ttf
		mgoth   /usr/share/fonts/kochi-substitute/kochi-gothic-subst.ttf
		fmin    /usr/share/fonts/kochi-substitute/kochi-mincho-subst.ttf
		fgoth   /usr/share/fonts/kochi-substitute/kochi-gothic-subst.ttf
		EOF
	fi
}

src_compile () {

	local TEXMF_PATH=$(kpsewhich --expand-var='$TEXMFMAIN')
	local myconf toolkit

	if use cjk ; then
		 export CPPFLAGS="${CPPFLAGS} -I/usr/include/freetype2"
		 myconf="${myconf} --with-vflib=vf2ft"
	fi

	if use motif ; then
		if use lesstif ; then
			append-ldflags -L/usr/X11R6/lib/lesstif -R/usr/X11R6/lib/lesstif
			export CPPFLAGS="${CPPFLAGS} -I/usr/X11R6/include/lesstif"
		fi
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
		$(use_enable cjk freetype) \
		$(use_with libwww system-wwwlib) \
		--with-x-toolkit="${toolkit}" \
		${myconf} || die "econf failed"

	cd texk/xdvik
	make texmf=${TEXMF_PATH} || die
	use emacs && elisp-compile xdvi-search.el
}

src_install () {

	dodir /etc/texmf/xdvi /etc/X11/app-defaults

	local TEXMF_PATH=$(kpsewhich --expand-var='$TEXMFMAIN')

	cd ${S}/texk/xdvik
	einstall texmf=${D}${TEXMF_PATH} || die "install failed"

	mv ${D}${TEXMF_PATH}/xdvi/XDvi ${D}etc/X11/app-defaults
	dosym {/etc/X11/app-defaults,${TEXMF_PATH}}/XDvi
	for i in $(find ${D}${TEXMF_PATH}/xdvi -type f -maxdepth 1) ; do
		mv $i ${D}etc/texmf/xdvi
		dosym {/etc/texmf,${TEXMF_PATH}}/xdvi/$(basename $i)
	done

	dodoc ANNOUNCE BUGS FAQ README.*
	if use cjk; then
		dodoc CHANGES.xdvik-jp
		docinto READMEs
		dodoc READMEs/*
	fi

	use emacs && elisp-install tex-utils *.el *.elc
}
