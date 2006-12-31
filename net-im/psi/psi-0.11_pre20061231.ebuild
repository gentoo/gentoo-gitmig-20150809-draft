# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/psi/psi-0.11_pre20061231.ebuild,v 1.1 2006/12/31 12:13:26 troll Exp $

inherit confutils eutils qt4

MY_PV="${PV:8:4}-${PV:12:2}-${PV:14:2}"
MY_P="${PN}-dev-snapshot-${MY_PV}"

IUSE="doc jingle plugins sasl spell ssl xscreensaver"

DESCRIPTION="QT 4.x Jabber Client, with Licq-like interface"
HOMEPAGE="http://psi-im.org/"
SRC_URI="http://psi-im.org/files/snapshot/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

S="${WORKDIR}/${MY_P}"

DEPEND="$(qt4_min_version 4.2)
	media-libs/libpng
	sys-libs/zlib
	dev-libs/glib
	doc? ( app-doc/doxygen )
	jingle? ( ~net-libs/ortp-0.7.1
		media-libs/speex
		media-libs/alsa-lib )
	sasl? ( dev-libs/cyrus-sasl )
	spell? ( app-text/aspell )
	ssl? ( dev-libs/openssl )
	xscreensaver? ( x11-misc/xscreensaver )"

RDEPEND="${DEPEND}"

pkg_setup() {
	if use jingle && !(built_with_use x11-libs/qt qt3support); then
		eerror "In order to compile psi with jingle support (google/talk"
		eerror "xmpp extension) you will need to recompile qt4 with"
		eerror "qt3support use flag enabled."
		die "Recompile qt4 with qt3support use flag enabled or disable jingle support in psi"
	fi;
}

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/psi-jingle-gcc4.patch
}

src_compile() {
	# growl is mac osx extension only - maybe someday we will want this
	local myconf="--disable-growl"

	# jingle is still alpha code...
	if use jingle; then
		mv configure-jingle configure
		chmod +x configure

		myconf="${myconf}  --enable-jingle"
	else
		# xmms must die!
		myconf="${myconf}  --disable-xmms"
	fi;

	QTDIR=/usr/lib ./configure \
		--prefix=/usr \
		$(enable_extension_disable xss xscreensaver) \
		$(enable_extension_disable cyrussasl sasl) \
		$(enable_extension_disable aspell spell) \
		$(enable_extension_disable openssl ssl) \
		$(use_enable plugins) \
		${myconf} || die "configure failed"

	# for custom CXXFLAGS - should use eqmake in near future
	cd ${S}/src
	qmake src.pro \
		QTDIR=/usr/lib \
		QMAKE_CFLAGS_RELEASE="${CFLAGS}" \
		QMAKE_CXXFLAGS_RELEASE="${CXXFLAGS}" \
		QMAKE=/usr/bin/qmake \
		QMAKE_RPATH= \
		"CONFIG+=no_fixpath release" \
		|| die "qmake failed"

	cd ${S}
	qmake psi.pro \
		QTDIR=/usr/lib \
		QMAKE_CFLAGS_RELEASE="${CFLAGS}" \
		QMAKE_CXXFLAGS_RELEASE="${CXXFLAGS}" \
		QMAKE=/usr/bin/qmake \
		QMAKE_RPATH= \
		"CONFIG+=no_fixpath release" \
		|| die "qmake failed"

	# for now, we need bundled qca :/
	cd ${S}/third-party/qca
	qmake qca.pro \
		QTDIR=/usr/lib \
		QMAKE_CFLAGS_RELEASE="${CFLAGS}" \
		QMAKE_CXXFLAGS_RELEASE="${CXXFLAGS}" \
		QMAKE=/usr/bin/qmake \
		QMAKE_RPATH= \
		"CONFIG+=no_fixpath release" \
		|| die "qmake failed"

	cd ${S}
	emake || die "make failed"

	if use doc; then
		cd ${S}/doc
		make api_public
	fi;
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"

	#this way the docs will also be installed in the standard gentoo dir
	for i in roster system emoticons; do
		newdoc ${S}/iconsets/${i}/README README.${i}
	done;
	newdoc certs/README README.certs
	dodoc ChangeLog README TODO

	use doc && cp -ar ${S}/doc/api ${D}/usr/share/psi
}
