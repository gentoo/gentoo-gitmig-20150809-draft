# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/qca/qca-2.0.0-r2.ebuild,v 1.18 2009/04/26 15:32:25 yngwin Exp $

EAPI="1"

inherit eutils multilib qt4

DESCRIPTION="Qt Cryptographic Architecture (QCA)"
HOMEPAGE="http://delta.affinix.com/qca/"
SRC_URI="http://delta.affinix.com/download/${PN}/${PV%.*}/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="2"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="debug doc examples"
RESTRICT="test"

DEPEND="!<app-crypt/qca-1.0-r3
	x11-libs/qt-core:4"
RDEPEND="${DEPEND}"

pkg_setup() {
	if use debug; then
		if has_version "<x11-libs/qt-4.4.0_alpha1:4" && ! built_with_use x11-libs/qt:4 debug; then
			eerror "You are trying to compile ${PN} with USE=\"debug\""
			eerror "while x11-libs/qt:4 is built without this particular flag."
			die "Rebuild x11-libs/qt:4 with USE=\"debug\"."
		elif has_version "x11-libs/qt-core:4" && ! built_with_use x11-libs/qt-core:4 debug; then
			eerror "You are trying to compile ${PN} with USE=\"debug\""
			eerror "while x11-libs/qt-core:4 is built without this particular flag."
			die "Rebuild x11-libs/qt-core:4 with USE=\"debug\"."
		fi
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-debug-same-pkgconfig-file.patch"
}

src_compile() {
	_libdir=$(get_libdir)
	local myconf
	if use debug; then
		myconf="--debug"
	else
		myconf="--release"
	fi

	# Multilib fix.
	sed -e "/pcfiles.path/s:lib:${_libdir}:" \
		-i "${S}"/configure || die "Multilib fix failed."

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
