# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/wengophone/wengophone-2.0_pre20099999.ebuild,v 1.1 2006/05/23 21:59:45 genstef Exp $

inherit subversion eutils toolchain-funcs

DESCRIPTION="Wengophone NG is a VoIP client featuring the SIP protcol"
HOMEPAGE="http://dev.openwengo.com"
SRC_URI=""
ESVN_REPO_URI="http://dev.openwengo.com/svn/openwengo/wengophone-ng/trunk"
ESVN_OPTIONS="--username guest --password guest"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-*"
IUSE=""

RDEPEND="dev-libs/boost
	dev-libs/glib
	dev-libs/openssl
	media-libs/alsa-lib
	net-libs/gnutls
	|| ( x11-libs/libX11 virtual/x11 )
	>=x11-libs/qt-4.1"

DEPEND="${RDEPEND}
	media-libs/speex
	dev-util/scons"

pkg_setup() {
	if ! built_with_use dev-libs/boost threads; then
		eerror "This package requires dev-libs/boost compiled with threads support."
		eerror "Please reemerge dev-libs/boost with USE=\"threads\"."
		die "Please reemerge dev-libs/boost with USE=\"threads\"."
	fi

	if test $(gcc-major-version) -ge 4 \
		&& test $(gcc-minor-version) -ge 1; then
		eerror "This does not yet build with >=gcc-4.1, see bug #133837"
		die "Please switch to gcc-4.0 for compiling"
	fi
	#if ! grep visit_each.hpp /usr/include/boost/bind.hpp >/dev/null 2>&1 \
	#	eerror "You need to add #include <boost/visit_each.hpp> in"
	#	eerror "/usr/include/boost/bind.hpp to build with gcc-4.1"
	#	die "Please fix your includes"
}

src_compile() {
	sed -i -e "s/File:://" libs/util/util/include/util/File.h
	# This breaks runtime, and we have no idea how to fix it properly
	#sed -i -e "s:c = connect(slot);://\0:" libs/util/util/include/util/Event.h

	QTLIBDIR=/usr/lib/qt4 QTDIR=/usr QTINCLUDEDIR=/usr/include/qt4 \
		scons qtwengophone \
		mode=release || die "scons failed"
}

src_install() {
	cd release-symbols
	insinto /opt/wengophone
	doins -r emoticons pics sounds
	exeinto /opt/wengophone
	doexe wengophone/src/presentation/qt/qtwengophone
	exeinto /opt/wengophone/lib
	doexe wifo/phapi/libphapi.so libs/curl/libowcurl.so
	make_wrapper wengophone ./qtwengophone /opt/wengophone /opt/wengophone/lib
	newicon ${S}/wengophone/src/presentation/qt/pics/contact/wengo.png wengophone.png
	make_desktop_entry wengophone
}
