# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/qca/qca-2.0.1-r1.ebuild,v 1.2 2009/04/26 15:32:25 yngwin Exp $

EAPI="2"

inherit eutils multilib qt4

DESCRIPTION="Qt Cryptographic Architecture (QCA)"
HOMEPAGE="http://delta.affinix.com/qca/"
SRC_URI="http://delta.affinix.com/download/${PN}/${PV%.*}/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="debug doc examples"
RESTRICT="test"

DEPEND="!<app-crypt/qca-1.0-r3
	x11-libs/qt-core:4[debug=]"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-pcfilespath.patch
}

src_configure() {
	_libdir=$(get_libdir)
	local myconf
	use debug && myconf="--debug" || myconf="--release"
	eqmake4 || die "eqmake failed"

	./configure \
		--prefix=/usr \
		--qtdir=/usr \
		--includedir="/usr/include/qca2" \
		--libdir="/usr/${_libdir}/qca2" \
		--no-separate-debug-info \
		--disable-tests \
		${myconf} \
		|| die "configure failed"

	eqmake4 ${PN}.pro
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"
	dodoc README TODO || die "dodoc failed."

	cat <<-EOF > "${WORKDIR}"/44qca2
	LDPATH=/usr/${_libdir}/qca2
	EOF
	doenvd "${WORKDIR}"/44qca2

	if use doc; then
		dohtml "${S}"/apidocs/html/* || die "Failed to install documentation"
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}/
		doins -r "${S}"/examples || die "Failed to install examples"
	fi
}
