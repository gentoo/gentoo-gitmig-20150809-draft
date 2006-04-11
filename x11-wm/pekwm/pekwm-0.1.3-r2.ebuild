# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/pekwm/pekwm-0.1.3-r2.ebuild,v 1.12 2006/04/11 04:36:39 fserb Exp $

inherit eutils

IUSE="truetype perl xinerama"

DESCRIPTION="A small window mananger based on aewm++"
HOMEPAGE="http://pekwm.pekdon.net/"
SRC_URI="http://pekwm.pekdon.net/files/source/${P}.tar.gz
	mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"

DEPEND="|| ( (
		xinerama? ( x11-libs/libXinerama )
		x11-libs/libXpm
		x11-libs/libXrandr
		x11-libs/libXrender
		)
		virtual/x11
	)
	truetype? ( virtual/xft )
	perl? ( dev-libs/libpcre )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-manpath-gentoo.diff
}

src_compile() {
	econf \
		`use_enable truetype xft` \
		`use_enable xinerama` \
		`use_enable perl pcre` \
		--enable-harbour \
		${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	cd ${S}
	dodoc docs/pekwmdocs.txt AUTHORS ChangeLog* INSTALL LICENSE README* NEWS ROADMAP TODO
	dohtml docs/pekwmdocs.html
}
