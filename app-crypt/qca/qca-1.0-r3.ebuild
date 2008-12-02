# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/qca/qca-1.0-r3.ebuild,v 1.11 2008/12/02 23:15:17 ranger Exp $

EAPI=1

inherit eutils qt3

DESCRIPTION="Qt Cryptographic Architecture (QCA)"
HOMEPAGE="http://delta.affinix.com/qca/"
SRC_URI="http://delta.affinix.com/download/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="x11-libs/qt:3"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/qca-pathfix.patch
	#This is needed just in bsd, but make no harm in linux
	epatch "${FILESDIR}"/qca-1.0-fbsd.patch
}

src_compile() {
	./configure --prefix=/usr || die "configure failed"
	sed -i \
		-e "/^CFLAGS/s:$: ${CFLAGS}:" \
		-e "/^CXXFLAGS/s:$: ${CXXFLAGS}:" \
		-e "/-strip/d" \
		Makefile
	emake || die "emake failed"
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "make install failed"

	dodir "/usr/include/qca1"
	dodir "/usr/lib/qca1"
	mv "${D}/usr/include"/* "${D}/usr/include/qca1"
	mv "${D}/usr/lib"/* "${D}/usr/lib/qca1"

	local _libdir=$(get_libdir)
	if [[ "${_libdir}" != "lib" ]]; then
		mv "${D}"/usr/lib "${D}"/usr/${_libdir}
	fi

	cat <<-EOF > "${T}/44qca1"
	LDPATH=/usr/${_libdir}/qca1
	EOF
	doenvd "${T}/44qca1"
}
