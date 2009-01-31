# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/italc/italc-1.0.9.ebuild,v 1.1 2009/01/31 21:21:12 jokey Exp $

EAPI=2

inherit autotools qt4 eutils autotools

DESCRIPTION="Intelligent Teaching And Learning with Computers (iTALC) supports working with computers in school"
HOMEPAGE="http://italc.sourceforge.net/"
SRC_URI="mirror://sourceforge/italc/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="X v4l crypt xinerama threads fbcon system-libvncserver"

RDEPEND="dev-libs/lzo
	sys-apps/tcp-wrappers
	media-libs/jpeg
	sys-libs/zlib
	dev-libs/openssl
	x11-libs/qt-core
	x11-libs/qt-xmlpatterns
	system-libvncserver? ( net-libs/libvncserver )
	xinerama? ( x11-libs/libXinerama )
	X? ( x11-libs/libICE
		x11-libs/libSM
		x11-libs/libX11
		x11-libs/libXdamage
		x11-libs/libXext
		x11-libs/libXfixes
		x11-libs/libXrandr
		x11-libs/libXtst
		x11-misc/xinput
		x11-libs/qt-gui:4 )"
DEPEND="${RDEPEND}
	X? ( x11-proto/inputproto )"

pkg_setup() {
	enewgroup italc
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-qt4-libpath.patch
	epatch "${FILESDIR}"/${P}-strip.patch
	use system-libvncserver && epatch "${FILESDIR}"/${P}-system-libvncserver.patch
	eautoreconf
}

src_configure() {
	econf \
		"--with-qtdir=/usr" \
		"--with-linux" \
		"--with-uinput" \
		"--without-macosx-native" \
		$(use_with xinerama) \
		$(use_with X x) \
		$(use_with X xkeyboard) \
		$(use_with X xrandr) \
		$(use_with X xfixes) \
		$(use_with X xdamage) \
		$(use_with X xtrap) \
		$(use_with X xrecord) \
		$(use_with X dpms) \
		$(use_with v4l) \
		$(use_with fbcon fbdev) \
		$(use_with fbcon fbpm) \
		$(use_with threads pthread) \
		$(use_with crypt) \
		|| die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	rm -r "${D}/usr/share/italc"
	dodoc TODO README AUTHORS INSTALL ChangeLog

	# -- disabled per 2007-04-04 as the icon is missing in upstream file
	# -- joke
	# Install server logo
	#newicon ima/resources/client_manager.png ${PN}.png
	#make_desktop_entry "${PN}" "iTALC Master" "${PN}.png" "Qt;KDE;Education"
}

pkg_postinst() {
	elog "On the master, please run "
	elog "# emerge --config =${CATEGORY}/${PF}"

	elog "Please add the logins of master users (teachers) to the italc group by running"
	elog "# usermod -a -G italc <loginname>"

	elog ""
}

pkg_config() {
	if [ ! -d /etc/italc/keys ] ; then
		einfo "Creating public and private keys for italc in /etc/italc/keys."
		/usr/bin/ica -role teacher -createkeypair > /dev/null
		eend $?
		einfo "Setting chmod 640 on private keys."
		chgrp -R italc /etc/italc
		chmod -R o-rwx /etc/italc/keys/private
	else
		einfo "Not creating new keypair, as /etc/italc/keys already exists"
	fi
}
