# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/mplinuxman/mplinuxman-1.5.ebuild,v 1.8 2009/09/06 17:51:20 ssuominen Exp $

EAPI=2
inherit eutils toolchain-funcs

DESCRIPTION="Manager for MPMan F60/55/50 MP3 players."
HOMEPAGE="http://mplinuxman.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${PN}-source-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2
	media-sound/mpg123"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

S=${WORKDIR}/${PN}

src_prepare() {
	epatch "${FILESDIR}"/${P}-stringh.patch \
		"${FILESDIR}"/${P}-makefile.patch
}

src_compile() {
	tc-export CC
	emake || die "emake failed"
	cd extra/mp_util
	emake || die "emake failed"
}

src_install() {
	dobin ${PN} extra/mp_util/{mputil,mputil_smart} || die "dobin failed"

	dodir /usr/share/locale/{de,es,fr,ja,nl}/LC_MESSAGES

	DESTDIR="${D}" emake install-po || die "emake install-po failed"

	newicon logo.xpm ${PN}.xpm
	make_desktop_entry ${PN} ${PN} ${PN} "AudioVideo;Audio;GTK"

	dodoc CHANGES README extra/mp_util/USAGE.txt
}
