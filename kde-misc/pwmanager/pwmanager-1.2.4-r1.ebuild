# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/pwmanager/pwmanager-1.2.4-r1.ebuild,v 1.1 2007/04/01 16:23:33 carlo Exp $

inherit kde

DESCRIPTION="Password manager for KDE supporting chipcard access and encryption."
HOMEPAGE="http://passwordmanager.sourceforge.net"
SRC_URI="mirror://sourceforge/passwordmanager/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="smartcard"

DEPEND="smartcard? ( >=sys-libs/libchipcard-1.9 )
	sys-libs/zlib
	app-arch/bzip2"

need-kde 3.5

LANGS_PKG=${PN}-i18n-${PV}
LANGS="ca da de el es et fr hu it lt nl pl ro sv"

for X in ${LANGS}; do
	SRC_URI="${SRC_URI} linguas_${X}? ( mirror://sourceforge/passwordmanager/${LANGS_PKG}.tar.bz2 )"
	IUSE="${IUSE} linguas_${X}"
done

src_compile() {
	local myconf="--enable-kwallet"

	if use smartcard; then
		myconf="${myconf} --enable-pwmanager-smartcard	\
			 --disable-pwmanager-libchipcard1	\
			 --enable-pwmanager-libchipcard2"
	else
		myconf="${myconf} --disable-pwmanager-smartcard"
	fi

	kde_src_compile

	if [ -d "${WORKDIR}/${LANGS_PKG}" ]; then
		KDE_S="${WORKDIR}/${LANGS_PKG}"
		for X in ${LANGS}; do
			use linguas_${X} || DO_NOT_COMPILE="${DO_NOT_COMPILE} ${X}"
		done
		export DO_NOT_COMPILE

		kde_src_compile
	fi
}

src_install() {
	KDE_S=""
	kde_src_install

	if [ -d "${WORKDIR}/${LANGS_PKG}" ]; then
		KDE_S="${WORKDIR}/${LANGS_PKG}"
		kde_src_install
	fi
}

pkg_preinst() {
	kde_pkg_preinst
	dodir /usr/share/applications/kde/
	mv ${D}/usr/share/applnk/Applications/pwmanager.desktop ${D}/usr/share/applications/kde/
}