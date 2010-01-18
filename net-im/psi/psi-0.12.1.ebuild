# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/psi/psi-0.12.1.ebuild,v 1.11 2010/01/18 19:01:45 armin76 Exp $

EAPI="2"

inherit eutils qt4 multilib

LANGPACK_VER="20090217"

DESCRIPTION="Qt4 Jabber client, with Licq-like interface"
HOMEPAGE="http://psi-im.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2
	mirror://gentoo/${PN}-langs-${LANGPACK_VER}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm hppa ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="crypt dbus debug doc spell ssl xscreensaver"
RESTRICT="test"

LANGS="cs de eo es_ES fr it mk pl pt_BR ru uk ur_PK vi zh zh_TW"
for LNG in ${LANGS}; do
	IUSE="${IUSE} linguas_${LNG}"
	#SRC_URI="${SRC_URI} http://psi-im.org/download/lang/psi_${LNG/ur_PK/ur_pk}.qm"
done

COMMON_DEPEND=">=x11-libs/qt-gui-4.4:4[qt3support,dbus?]
	>=app-crypt/qca-2.0.2:2
	spell? ( app-text/aspell )
	xscreensaver? ( x11-libs/libXScrnSaver )"

DEPEND="${COMMON_DEPEND}
	doc? ( app-doc/doxygen )"

RDEPEND="${COMMON_DEPEND}
	crypt? ( >=app-crypt/qca-gnupg-2.0.0_beta2 )
	ssl? ( >=app-crypt/qca-ossl-2.0.0_beta2 )"

src_prepare() {
	epatch "${FILESDIR}/${P}-qt-4.5-compatibility.patch"
	epatch "${FILESDIR}/${P}-build-error.patch"
}

src_configure() {
	# disable growl as it is a MacOS X extension only
	local myconf="--prefix=/usr --qtdir=/usr"
	myconf="${myconf} --disable-growl --disable-bundled-qca"
	use debug && myconf="${myconf} --enable-debug"
	use dbus || myconf="${myconf} --disable-qdbus"
	use spell || myconf="${myconf} --disable-aspell"
	use xscreensaver || myconf="${myconf} --disable-xss"

	# cannot use econf because of non-standard configure script
	./configure ${myconf} || die "configure failed"
}

src_compile() {
	eqmake4 ${PN}.pro

	SUBLIBS="-L/usr/${get_libdir}/qca2" emake || die "emake failed"

	if use doc; then
		cd doc
		mkdir -p api # 259632
		make api_public || die "make api_public failed"
	fi
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"

	# this way the docs will be installed in the standard gentoo dir
	newdoc iconsets/roster/README README.roster || die
	newdoc iconsets/system/README README.system || die
	newdoc certs/README README.certs || die
	dodoc README || die

	if use doc; then
		cd doc
		dohtml -r api || die "dohtml failed"
	fi

	# install translations
	cd "${WORKDIR}/${PN}-langs"
	insinto /usr/share/${PN}/
	for LNG in ${LANGS}; do
		if use linguas_${LNG}; then
			doins ${PN}_${LNG/ur_PK/ur_pk}.qm || die
		fi
	done
}
