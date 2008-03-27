# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/psi/psi-0.11.ebuild,v 1.6 2008/03/27 17:00:21 jer Exp $

inherit eutils qt4 multilib

DESCRIPTION="QT 4.x Jabber Client, with Licq-like interface"
HOMEPAGE="http://psi-im.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

IUSE="crypt doc kernel_linux spell ssl xscreensaver"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86"
RESTRICT="test"

COMMON_DEPEND="$(qt4_min_version 4.2.3)
	=app-crypt/qca-2*
	spell? ( app-text/aspell )
	xscreensaver? ( x11-libs/libXScrnSaver )"

DEPEND="${COMMON_DEPEND}
	doc? ( app-doc/doxygen )"

RDEPEND="${COMMON_DEPEND}
	crypt? ( >=app-crypt/qca-gnupg-2.0.0_beta2 )
	ssl? ( >=app-crypt/qca-ossl-2.0.0_beta2 )"

QT4_BUILT_WITH_USE_CHECK="qt3support png"

src_compile() {
	# disable growl as it is a mac osx extension only
	local myconf="--prefix=/usr --qtdir=/usr"
	myconf="${myconf} --disable-growl --disable-bundled-qca"
	use kernel_linux || myconf="${myconf} --disable-dnotify"
	use spell || myconf="${myconf} --disable-aspell"
	use xscreensaver || myconf="${myconf} --disable-xss"

	# cannot use econf because of non-standard configure script
	./configure ${myconf} || die "configure failed"

	eqmake4 ${PN}.pro

	SUBLIBS="-L/usr/${get_libdir}/qca2" emake || die "emake failed"

	if use doc; then
		cd doc
		make api_public || die "make api_public failed"
	fi
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"

	# this way the docs will be installed in the standard gentoo dir
	newdoc iconsets/roster/README README.roster
	newdoc iconsets/system/README README.system
	newdoc certs/README README.certs
	dodoc README

	if use doc; then
		cd doc
		dohtml -r api || die "dohtml failed"
	fi
}
