# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/qca/qca-2.0.2-r2.ebuild,v 1.9 2009/12/14 16:44:17 abcd Exp $

EAPI="2"

inherit eutils multilib qt4

DESCRIPTION="Qt Cryptographic Architecture (QCA)"
HOMEPAGE="http://delta.affinix.com/qca/"
SRC_URI="http://delta.affinix.com/download/${PN}/${PV%.*}/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="2"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="debug doc examples"
RESTRICT="test"

DEPEND="x11-libs/qt-core:4[debug?]"
RDEPEND="${DEPEND}
	!<app-crypt/qca-1.0-r3:0
"

src_prepare() {
	epatch "${FILESDIR}"/${P}-pcfilespath.patch
}

src_configure() {
	use prefix || EPREFIX=

	_libdir=$(get_libdir)

	./configure \
		--prefix="${EPREFIX}"/usr \
		--qtdir="${EPREFIX}"/usr \
		--includedir="${EPREFIX}"/usr/include/qca2 \
		--libdir="${EPREFIX}"/usr/${_libdir}/qca2 \
		--no-separate-debug-info \
		--disable-tests \
		--$(use debug && echo debug || echo release) \
		|| die "configure failed"

	eqmake4
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"
	dodoc README TODO || die "dodoc failed"

	cat <<-EOF > "${WORKDIR}"/44qca2
	LDPATH="${EPREFIX}/usr/${_libdir}/qca2"
	EOF
	doenvd "${WORKDIR}"/44qca2 || die

	if use doc; then
		dohtml "${S}"/apidocs/html/* || die "Failed to install documentation"
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}/
		doins -r "${S}"/examples || die "Failed to install examples"
	fi
}
