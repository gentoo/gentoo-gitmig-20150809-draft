# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/psi/psi-0.9.3_rc1.ebuild,v 1.1 2004/12/27 13:20:30 humpback Exp $

VER="0.9.3"
REV="-test1"
MY_PV="${VER}${REV}"
MY_P="${PN}-${MY_PV}"

IUSE="kde ssl crypt"
#RESTRICT="nomirror"
QV="2.0"
SRC_URI="http://people.ex.ac.uk/kismith/psi/${MY_P}.tar.bz2"
DESCRIPTION="QT 3.x Jabber Client, with Licq-like interface"
HOMEPAGE="http://psi.affinix.com"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~hppa ~amd64 ~sparc"

#After final relase we do not need this
S="${WORKDIR}/${MY_P}"

DEPEND="ssl? ( >=dev-libs/openssl-0.9.6c
	>=app-crypt/qca-1.0
	>=app-crypt/qca-tls-1.0 )
	crypt? ( >=app-crypt/gnupg-1.2.2 )
	>=x11-libs/qt-3"

src_compile() {
	use kde || myconf="${myconf} --disable-kde"
	./configure --prefix=/usr $myconf || die "Configure failed"
	# for CXXFLAGS from make.conf
	qmake psi.pro \
		QMAKE_CXXFLAGS_RELEASE="${CXXFLAGS}" \
		QMAKE_RPATH= \
		|| die "Qmake failed"

	addwrite "$HOME/.qt"
	addwrite "$QTDIR/etc/settings"
	emake || die "Make failed"
}

src_install() {
	dodoc README TODO
	make INSTALL_ROOT="${D}" install
	#this away the docs will also be installed in the standard gentoo dir
	for i in roster system emoticons; do
		newdoc ${S}/iconsets/${i}/README README.${i}
	done;
	newdoc certs/README README.certs
}
