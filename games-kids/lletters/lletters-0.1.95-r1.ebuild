# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-kids/lletters/lletters-0.1.95-r1.ebuild,v 1.8 2004/11/05 04:53:36 josejx Exp $

inherit games

DESCRIPTION="Game that helps young kids learn their letters and numbers"
HOMEPAGE="http://lln.sourceforge.net/"
SRC_URI="mirror://sourceforge/lln/${PN}-media-0.1.9a.tar.gz
	mirror://sourceforge/lln/${P}.tar.gz"

KEYWORDS="x86 amd64 ~ppc"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/x11
	media-libs/imlib
	=x11-libs/gtk+-1.2*"

RDEPEND="${DEPEND}
	nls? ( sys-devel/gettext )"

DEPEND="${DEPEND}
	>=sys-apps/sed-4"

IUSE="nls"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	cp -f "${FILESDIR}/tellhow.h.gentoo" tellhow.h || die "cp failed"
	unpack lletters-media-0.1.9a.tar.gz
}

src_compile() {
	if [ "${ARCH}" = "amd64" ]; then
		aclocal
		autoheader
		WANT_AUTOMAKE=1.4 automake -a -c
		autoconf
		libtoolize -c -f
	fi

	egamesconf `use_enable nls` || die
	# Work around the po/Makefile (bug #43762)
	# Why don't people honor DESTDIR?
	sed -i \
		-e '/^prefix =/ s:/.*:$(DESTDIR)/usr:' po/Makefile \
			|| die "sed po/Makefile failed"
	emake || die "emake failed"
}

src_install () {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS CREDITS ChangeLog README* TODO || die "dodoc failed"
	prepgamesdirs
}
