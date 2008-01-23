# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/qca/qca-2.0.0-r2.ebuild,v 1.4 2008/01/23 12:46:37 ingmar Exp $

EAPI="1"

inherit eutils multilib qt4

DESCRIPTION="Qt Cryptographic Architecture (QCA)"
HOMEPAGE="http://delta.affinix.com/qca/"
SRC_URI="http://delta.affinix.com/download/qca/${PV%.*}/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="2"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc examples"
RESTRICT="test"

DEPEND="
	!<app-crypt/qca-1.0-r3
	>=x11-libs/qt-4.2.0:4"
RDEPEND="${DEPEND}"

pkg_setup() {
	if use debug && ! built_with_use x11-libs/qt:4 debug; then
		echo
		eerror "You are trying to compile ${PN} package with USE=\"debug\""
		eerror "while qt4 is built without this particular flag."
		echo
		eerror "Possible solutions to this problem are:"
		eerror "a) install package ${PN} without debug USE flag"
		eerror "b) re-emerge qt4 with debug USE flag"
		echo
		die "can't emerge ${PN} with debug USE flag"
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
