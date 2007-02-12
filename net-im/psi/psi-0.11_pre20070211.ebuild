# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/psi/psi-0.11_pre20070211.ebuild,v 1.1 2007/02/12 02:05:26 troll Exp $

inherit confutils eutils qt4

MY_PV="${PV:8:4}-${PV:12:2}-${PV:14:2}"
MY_P="${PN}-dev-snapshot-${MY_PV}"

IUSE="doc jingle plugins sasl spell ssl xscreensaver"

DESCRIPTION="QT 4.x Jabber Client, with Licq-like interface"
HOMEPAGE="http://psi-im.org/"
SRC_URI="http://psi-im.org/files/snapshot/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/${MY_P}"

PLUGINS="chess echo noughtsandcrosses"

DEPEND="$(qt4_min_version 4.2)
	media-libs/libpng
	sys-libs/zlib
	dev-libs/glib
	doc? ( app-doc/doxygen )
	jingle? ( ~net-libs/ortp-0.7.1
		media-libs/speex )
	sasl? ( dev-libs/cyrus-sasl )
	spell? ( app-text/aspell )
	ssl? ( dev-libs/openssl )
	xscreensaver? ( x11-misc/xscreensaver )"

RDEPEND="${DEPEND}"

pkg_setup() {
	if ! (built_with_use x11-libs/qt qt3support); then
		eerror "In order to compile psi with jingle support (google/talk"
		eerror "xmpp extension) you will need to recompile qt4 with"
		eerror "qt3support use flag enabled."
		die "Recompile qt4 with qt3support use flag enabled"
	fi;
}

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/psi-jingle-gcc4.patch

	if use plugins; then
		epatch ${FILESDIR}/psi-ptr_64bit_fix.patch
		epatch ${FILESDIR}/psi-echoplugin.patch
	fi;
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

	if use jingle; then
		cd ${S}/third-party/libjingle
		qmake libjingle.pro \
			QTDIR=/usr/lib \
			QMAKE_CFLAGS_RELEASE="${CFLAGS}" \
			QMAKE_CXXFLAGS_RELEASE="${CXXFLAGS}" \
			QMAKE=/usr/bin/qmake \
			QMAKE_RPATH= \
			"CONFIG+=no_fixpath release" \
			|| die "qmake failed"

	fi;

	cd ${S}
	emake || die "make failed"

	use plugins && for pl in ${PLUGINS}; do
		cd ${S}/src/plugins/generic/${pl}
		qmake ${pl}plugin.pro \
			QTDIR=/usr/lib \
			QMAKE_CFLAGS_RELEASE="${CFLAGS}" \
			QMAKE_CXXFLAGS_RELEASE="${CXXFLAGS}" \
			QMAKE=/usr/bin/qmake \
			QMAKE_RPATH= \
			"CONFIG+=no_fixpath release" \
			|| die "qmake failed"
		make || die "make plugin ${pl} failed"
	done

	if use doc; then
		cd ${S}/doc
		make api_public
	fi;
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"

	#this way the docs will also be installed in the standard gentoo dir
	newdoc ${S}/iconsets/roster/README README.roster
	newdoc ${S}/iconsets/system/README README.system
	newdoc certs/README README.certs
	dodoc ChangeLog README TODO

	if use plugins; then
		dodir /usr/share/psi/plugins
		for pl in ${PLUGINS}; do
			cp ${S}/src/plugins/generic/${pl}/lib${pl}plugin.so ${D}/usr/share/psi/plugins
		done;
	fi;

	use doc && cp -ar ${S}/doc/api ${D}/usr/share/psi
}
