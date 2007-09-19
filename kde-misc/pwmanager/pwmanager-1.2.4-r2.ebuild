# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/pwmanager/pwmanager-1.2.4-r2.ebuild,v 1.2 2007/09/19 21:03:07 pylon Exp $

inherit kde

DESCRIPTION="Password manager for KDE supporting chipcard access and encryption."
HOMEPAGE="http://passwordmanager.sourceforge.net"
SRC_URI="mirror://sourceforge/passwordmanager/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

need-kde 3.5

LANGS_PKG=${PN}-i18n-${PV}
LANGS="ca da de el es et fr hu it lt nl pl ro sv"

for X in ${LANGS}; do
	SRC_URI="${SRC_URI} linguas_${X}? ( mirror://sourceforge/passwordmanager/${LANGS_PKG}.tar.bz2 )"
	IUSE="${IUSE} linguas_${X}"
done

src_compile() {
	local myconf="--enable-kwallet --disable-pwmanager-smartcard"

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
