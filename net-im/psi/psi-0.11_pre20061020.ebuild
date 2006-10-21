# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/psi/psi-0.11_pre20061020.ebuild,v 1.1 2006/10/21 00:10:13 genstef Exp $

inherit eutils qt4

MY_PV="${PV:8:4}-${PV:12:2}-${PV:14:2}"
MY_P="${PN}-dev-snapshot-${MY_PV}"

HTTPMIRR="http://vivid.dat.pl/psi"
IUSE="sasl spell ssl xscreensaver"

DESCRIPTION="QT 4.x Jabber Client, with Licq-like interface"
HOMEPAGE="http:/psi-im.org/"
# translations from http://tanoshi.net/language.html
# polish translation contains special texts for patches from extras-version
SRC_URI="http://psi-im.org/files/snapshot/${MY_P}.tar.bz2"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/${MY_P}"

DEPEND="$(qt4_min_version 4.2)
	spell? ( app-text/aspell )
	sasl? ( dev-libs/cyrus-sasl )
	dev-libs/expat
	dev-libs/glib
	media-libs/alsa-lib
	media-libs/fontconfig
	media-libs/freetype
	media-libs/speex
	~net-libs/ortp-0.7.1
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXcursor
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXinerama
	x11-libs/libXrandr
	x11-libs/libXrender
	ssl? ( dev-libs/openssl )
	media-libs/libpng
	sys-libs/zlib
	xscreensaver? ( x11-misc/xscreensaver )"

RDEPEND="${DEPEND}"

src_compile() {
	epatch ${FILESDIR}/psi-jingle-gcc4.patch
	# growl is mac osx extension only - maybe someday we will want this
	local myconf="--disable-growl"

	use xscreensaver || myconf="${myconf} --disable-xss"
	use sasl || myconf="${myconf} --disable-cyrussasl"
	use spell || myconf="${myconf} --disable-aspell"
	use ssl || myconf="${myconf} --disable-openssl"

	chmod a+x configure-jingle
	QTDIR=/usr/lib ./configure-jingle \
		--prefix=/usr \
		--enable-jingle \
		--enable-plugins \
		${myconf} || die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"

	#this way the docs will also be installed in the standard gentoo dir
	for i in roster system emoticons; do
		newdoc ${S}/iconsets/${i}/README README.${i}
	done;
	newdoc certs/README README.certs
	dodoc ChangeLog README TODO
}
