# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/xqf/xqf-1.0.4-r1.ebuild,v 1.3 2006/01/07 18:09:13 wolf31o2 Exp $

inherit eutils
DESCRIPTION="A server browser for many FPS games (frontend for qstat)"
HOMEPAGE="http://www.linuxgames.com/xqf/"
SRC_URI="mirror://sourceforge/xqf/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc x86"
IUSE="nls geoip bzip2"

DEPEND="=x11-libs/gtk+-2*
	nls? ( sys-devel/gettext )
	geoip? ( dev-libs/geoip )
	bzip2? ( app-arch/bzip2 )"
RDEPEND="${DEPEND}
	>=games-util/qstat-2.8"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch ${FILESDIR}/gtk2.patch
	# "splash.png" is pretty generic #55949
	sed -i \
		-e 's:splash\.png:xqfsplash.png:' \
		src/{splash,dialogs}.c pixmaps/Makefile.in \
		|| die "sed failed"
	mv pixmaps/{,xqf}splash.png || die "mv failed"
}

src_compile() {
	econf \
		$(use_enable nls) \
		$(use_enable geoip) \
		$(use_enable bzip2) \
		$(use_enable debug) \
		--enable-gtk2 \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS BUGS ChangeLog NEWS README TODO
}
