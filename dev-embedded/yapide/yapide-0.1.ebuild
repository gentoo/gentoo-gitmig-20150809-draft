# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/yapide/yapide-0.1.ebuild,v 1.1 2004/08/05 11:30:03 dragonheart Exp $

inherit eutils

DESCRIPTION="Yet Another PIC IDE: a Microchip PIC simulator"
HOMEPAGE="http://www.mtoussaint.de/yapide.html"
SRC_URI="http://www.mtoussaint.de/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="virtual/libc
	>=x11-libs/qt-3.0.0
	dev-embedded/gputils"

DEPEND="${RDEPEND}
	sys-devel/gcc
	>=sys-apps/sed-4"

S="${WORKDIR}/YaPIDE-${PV}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-0.1-configure.patch
	epatch ${FILESDIR}/${PN}-0.1-nocflags.patch
}



src_compile() {

	REALHOME="${HOME}"
	mkdir -p ${T}/fakehome/.kde
	mkdir -p ${T}/fakehome/.qt
	export HOME="${T}/fakehome"
	addwrite "${QTDIR}/etc/settings"

	# things that should access the real homedir
	[ -d "${REALHOME}/.ccache" ] && ln -sf "${REALHOME}/.ccache" "${HOME}/"

	econf || die
	emake src/Makefile || die
	sed -i -e "s:^CFLAGS.*-D_REENTRANT:CFLAGS = ${CFLAGS} -D_REENTRANT:" \
		-e "s:^CXXFLAGS.*-D_REENTRANT:CXXFLAGS = ${CXXFLAGS} -D_REENTRANT:" \
		src/Makefile
	emake || die
}



src_install() {
	dobin bin/yapide
	dodoc AUTHORS COPYING KNOWNBUGS README
}

