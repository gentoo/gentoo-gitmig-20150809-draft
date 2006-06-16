# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/pwmanager/pwmanager-1.2.4.ebuild,v 1.4 2006/06/16 12:12:26 flameeyes Exp $

inherit kde

DESCRIPTION="Password manager for KDE supporting chipcard access and encryption."
HOMEPAGE="http://passwordmanager.sourceforge.net"
SRC_URI="mirror://sourceforge/passwordmanager/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="smartcard"

DEPEND="smartcard? ( sys-libs/libchipcard )
	sys-libs/zlib
	app-arch/bzip2"

need-kde 3.3

LANGS_PKG=${PN}-i18n-${PV}
LANGS="ca da de el es et fr hu it lt nl pl ro sv"

for X in ${LANGS}; do
	SRC_URI="${SRC_URI} linguas_${X}? ( mirror://sourceforge/passwordmanager/${LANGS_PKG}.tar.bz2 )"
	IUSE="${IUSE} linguas_${X}"
done

src_compile() {
	local myconf="--enable-kwallet"

	if use smartcard; then
		myconf="${myconf} --enable-pwmanager-smartcard"

		if has_version "=sys-libs/libchipcard-0.9*"; then
			myconf="${myconf} --enable-pwmanager-libchipcard1"
		else
			myconf="${myconf} --disable-pwmanager-libchipcard1"
		fi

		if has_version ">=sys-libs/libchipcard-1.9"; then
			myconf="${myconf} --enable-pwmanager-libchipcard2"
		else
			myconf="${myconf} --disable-pwmanager-libchipcard2"
		fi
	else
		myconf="${myconf} --disable-pwmanager-smartcard"
	fi

	kde_src_compile

	local _S="${S}"
	if [ -d "${WORKDIR}/${LANGS_PKG}" ]; then
		S="${WORKDIR}/${LANGS_PKG}"
		cd "${S}"

		for X in ${LANGS}; do
			use linguas_${X} || DO_NOT_COMPILE="${DO_NOT_COMPILE} ${X}"
		done
		export DO_NOT_COMPILE

		kde_src_compile
	fi
	S="${_S}"
}

src_install() {
	kde_src_install

	local _S="${S}"
	if [ -d "${WORKDIR}/${LANGS_PKG}" ]; then
		S="${WORKDIR}/${LANGS_PKG}"
		cd "${S}"
		kde_src_install
	fi
	S="${_S}"
}
