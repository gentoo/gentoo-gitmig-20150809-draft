# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/pekwm/pekwm-20050129.2.ebuild,v 1.1 2005/02/01 23:28:38 fserb Exp $

inherit eutils

MYPV=${PV/./-}
MYP=${PN}-dev-${PV%.*}
S=${WORKDIR}/${MYP}

IUSE="truetype perl xinerama imlib2 debug themes"

DESCRIPTION="A small window mananger based on aewm++"
HOMEPAGE="http://pekwm.org"
SRC_URI="http://pekwm.org/files/${PN}-dev-${MYPV}.tar.bz2
	themes? ( mirror://gentoo/${P}-themes.tar.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"

DEPEND="virtual/x11
	truetype? ( virtual/xft )
	perl? ( dev-libs/libpcre )
	imlib2? ( media-libs/imlib2 )
	themes? ( media-libs/imlib2 )"

src_unpack() {
	unpack ${A}
	if use themes; then
		unpack ${P}-themes.tar.bz2
	fi
}

src_compile() {
	if use imlib2 || use themes; then
		if ! built_with_use media-libs/imlib2 X ; then
			ewarn "you must emerge media-libs/imlib2 with X support to use pekwm with imlib2 or themes support"
			ewarn "please USE=\"X\" emerge media-libs/imlib2 before emerging pekwm"
			die "Cannot emerge with imlib2 without X USE flag"
		fi
	fi

	if use imlib2 || use themes; then
		UEIM="--enable-imlib2"
	else
		UEIM=""
	fi

	econf \
		`use_enable truetype xft` \
		`use_enable perl pcre` \
		`use_enable xinerama` \
		$UEIM \
		`use_enable debug` \
		--enable-menus --enable-harbour --enable-shape --enable-xrandr\
		${myconf} || die
	emake || die
}


src_install() {
	make DESTDIR=${D} install || die
	cd ${S}
	dodoc AUTHORS ChangeLog

	if use themes; then
		mv ${WORKDIR}/themes/* ${D}/usr/share/${PN}/themes/
	fi
}

pkg_postinst()
{
	if ! ( use imlib2 || use themes ); then
		ewarn "Altough USE=\"imlib2\" support is optional, it's highly recommended to use it"
		ewarn "since most of the themes for pekwm require imlib2 support"
	fi
}
