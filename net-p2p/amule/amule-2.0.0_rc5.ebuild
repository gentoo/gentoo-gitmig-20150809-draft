# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/amule/amule-2.0.0_rc5.ebuild,v 1.1 2004/07/19 14:20:39 squinky86 Exp $

MY_P=${P/m/M}
MY_P=${MY_P/_/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="aNOTHER wxWindows based eMule P2P Client"
HOMEPAGE="http://www.amule.org"
SRC_URI="http://download.berlios.de/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
# this is a release candidate- do not put in the stable tree yet
KEYWORDS="~x86 ~amd64"
IUSE="debug nls stats remote"
RESTRICT="nomirror"

EXTRA_ECONF="--disable-optimise"

# optimizations disabled for better stability
# new USE "noamulestats" disables aMule GUI statistics (wxCas) (require gd)
# new USE "noamuleremote" disables remote control utilities: webserver, 
# web client, amulecmd text client


DEPEND=">=x11-libs/wxGTK-2.4.2
	>=net-misc/curl-7.11.0
	>=dev-libs/crypto++-5.1
	>=sys-libs/zlib-1.2.1
	stats? ( >=media-libs/gd-2.0.22 )"

pkg_setup() {

	# GTK2 is unstable and not supported by aMule developers
	if wx-config --cppflags | grep gtk2 >& /dev/null; then
		einfo "Compiling ${PN} against wxGTK2 is not supported."
		die "wxGTK must be re-emerged with USE=-gtk2."
	fi

	# aMule doesn't compile against unicoded wxGTK at all.
	if wx-config --cppflags | grep gtk2u >& /dev/null; then
		einfo "${PN} will not build if wxGTK was compiled"
		einfo "with unicode support.  If you are using a version of"
		einfo "wxGTK <= 2.4.2, you must set USE=-gtk2.  In newer versions,"
		einfo "you must set USE=-unicode."
		die "wxGTK must be re-emerged without unicode suport"
	fi

}

src_compile() {

	use remote || EXTRA_ECONF="${EXTRA_ECONF} --disable-amulecmd \
							--disable-amulecmdgui \
							--disable-webserver \
							--disable-webservergui" \
			|| EXTRA_ECONF="${EXTRA_ECONF} --enable-amulecmd \
							--enable-amulecmdgui \
							--enable-webserver \
							--enable-webservergui"

	#workaround for broken configure (doesn't recognize --enable-wxcas)
	use stats || EXTRA_ECONF="${EXTRA_ECONF} --disable-wxcas"

	econf `use_enable nls` \
	`use_enable debug` || die

	emake -j1 || die
}

src_install() {
	make DESTDIR=${D} install || die
}
