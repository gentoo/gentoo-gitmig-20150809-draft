# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kload/kload-0.9.4-r1.ebuild,v 1.2 2009/08/08 22:16:28 ssuominen Exp $

inherit eutils

DESCRIPTION="A performance monitoring program for KDE/Linux"
HOMEPAGE="http://www.richard-schneider.de/uwe/kde/"
SRC_URI="http://www.richard-schneider.de/uwe/kde/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="kde"

RDEPEND="kde? ( =kde-base/kdelibs-3* )"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc43.diff
	epatch "${FILESDIR}"/${P}-glibc-2.10.patch
}

src_compile() {
	local TARGET="\$(SERVER)"
	use kde && TARGET="${TARGET} \$(CLIENT)"

	emake \
		QTDIR="${QTDIR}" \
		TARGET="${TARGET}" \
		KDEDIR="$(kde-config --prefix)" \
		CXXFLAGS="${CXXFLAGS} \$(KDEDEF) \$(QTDEF)" \
		CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dosbin kloadd
	newinitd "${FILESDIR}/kloadd.initd" kloadd
	newconfd "${FILESDIR}/kloadd.confd" kloadd
	if use kde; then
		dobin kload
		make_desktop_entry kload "Performace Monitor" ksysguard
	fi
	dodoc ChangeLog README
}
