# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xdvik/xdvik-22.84.3-r1.ebuild,v 1.1 2004/10/23 14:12:26 usata Exp $

inherit eutils flag-o-matic

IUSE="cjk libwww lesstif motif Xaw3d"

XDVIK_JP="xdvik-${PV}-20040825-jp"

DESCRIPTION="DVI previewer for X Window System"
SRC_URI="mirror://sourceforge/xdvi/${P}.tar.gz
	cjk? ( mirror://sourceforge.jp/xdvi/11043/${XDVIK_JP}.diff.gz )"
HOMEPAGE="http://sourceforge.net/projects/xdvi/
	http://xdvi.sourceforge.jp/"

KEYWORDS="~x86 ~alpha ~ppc ~sparc ~amd64 ~ppc64"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-libs/t1lib-5.0.2
	virtual/x11
	motif? ( lesstif? ( x11-libs/lesstif )
		!lesstif? ( x11-libs/openmotif ) )
	!motif? ( Xaw3d? ( x11-libs/Xaw3d ) )
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
	elif use Xaw3d ; then
		toolkit="xaw3d"
	else
		toolkit="xaw"
	fi

	econf --disable-multiplatform \
		--with-system-t1lib \
		$(use_enable cjk freetype) \
		$(use_with libwww system-wwwlib) \
		--with-x-toolkit="${toolkit}" \
		${myconf} || die "econf failed"

	cd texk/xdvik
	make || die
}

src_install () {

	dodir /etc/texmf/xdvi

	cd ${S}/texk/xdvik
	einstall texmf=${D}/usr/share/texmf \
		|| die "install failed"

	mv ${D}/usr/share/texmf/xdvi/{xdvi.cfg,XDvi} ${D}/etc/texmf/xdvi
	dosym {/etc,/usr/share}/texmf/xdvi/xdvi.cfg
	dosym {/etc,/usr/share}/texmf/xdvi/XDvi

	dodoc ANNOUNCE BUGS FAQ README.*
	if use cjk; then
		dodoc CHANGES.xdvik-jp
		docinto READMEs
		dodoc READMEs/*
	fi
}
