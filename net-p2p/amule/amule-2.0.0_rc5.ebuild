# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/amule/amule-2.0.0_rc5.ebuild,v 1.3 2004/07/23 23:41:38 mr_bones_ Exp $

MY_P=${P/m/M}
MY_P=${MY_P/_/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="aMule, the all-platform eMule p2p client"
HOMEPAGE="http://www.amule.org"
SRC_URI="http://download.berlios.de/${PN}/${MY_P}.tar.bz2"


LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug nls remote stats"
EXTRA_ECONF="--disable-optimise"

# USE "stats" enables external utilities (statistics and other)
# USE "remote" enables remote controlling utilities (webserver, text client)

DEPEND="remote? ( =x11-libs/wxGTK-2.4* )
	!remote? ( >=x11-libs/wxGTK-2.4.2-r1 )
	>=net-misc/curl-7.11.0
	>=dev-libs/crypto++-5.1-r1
	>=sys-libs/zlib-1.2.1
	stats? ( >=media-libs/gd-2.0.23 )"

pkg_setup() {

	# GTK2 is unstable on wxGTK 2.4 and not supported by aMule developers
	if wx-config --version | grep 2.4 >& /dev/null \
	&& wx-config --cppflags | grep gtk2 >& /dev/null; then
		einfo "Compiling ${PN} against wxGTK2 2.4.x is not supported."
		einfo "wxGTK must be re-emerged with USE=\"-gtk2\" or you can upgrade"
		einfo "to development snapshots 2.5.1, but this will break other"
		einfo "applications and the webserver. Please note that gtk2 support"
		einfo "is still experimental."
		die "wxGTK 2.4 must be re-emerged with USE=\"-gtk2\"."
	fi

}

src_compile() {
	econf `use_enable nls` \
	`use_enable remote amulecmd` \
	`use_enable remote amulecmdgui` \
	`use_enable remote webserver` \
	`use_enable remote webservergui` \
	`use_enable stats cas` \
	`use_enable stats wxcas` \
	`use_enable stats alc` \
	`use_enable stats alcc` \
	`use_enable debug` || die

	emake -j1 || die
}

src_install() {
	make DESTDIR=${D} install || die
}
