# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/umtsmon/umtsmon-0.9.ebuild,v 1.2 2009/06/20 22:18:47 mrness Exp $

EAPI=1

inherit eutils qt3

DESCRIPTION="Tool to control and monitor wireless mobile network cards (GPRS, EDGE, WCDMA, UMTS, EV-DO, HSDPA)"
HOMEPAGE="http://umtsmon.sourceforge.net/"
SRC_URI="mirror://sourceforge/umtsmon/${P}.src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/qt:3
	dev-libs/libusb:0"
RDEPEND="${DEPEND}
	net-dialup/ppp
	sys-apps/pcmciautils"

# for i18n support
# Supported languages and translated documentation
# Be sure all languages are prefixed with a single space!
MY_AVAILABLE_LINGUAS=" de es it nb_NO nl pl pt_PT pt_BR"
IUSE="${IUSE} ${MY_AVAILABLE_LINGUAS// / linguas_}"

src_compile() {
	eqmake3 || die "eqmake3 failed"
	emake || die "emake failed"

	#for i18n support
	local MY_LINGUAS="" lang

	for lang in ${MY_AVAILABLE_LINGUAS} ; do
		if use linguas_${lang} ; then
			MY_LINGUAS="${MY_LINGUAS} ${lang}"
		fi
	done
	if [[ -z "${MY_LINGUAS}" ]] ; then
		#If no language is selected, install 'em all
		MY_LINGUAS="${MY_AVAILABLE_LINGUAS}"
	fi

	einfo "Following langpacks will be installed:"
	einfo "   ${MY_LINGUAS}"

	for lang in ${MY_LINGUAS}; do
		lrelease i18n/umtsmon_${lang}.ts \
			|| die "failed to install langpack for ${lang} language"
	done
}

src_install() {
	dobin umtsmon || die "dobin failed"

	domenu umtsmon.desktop
	doicon images/128

	# for i18n support
	insinto /usr/share/umtsmon/translations
	doins i18n/*.qm

	dodoc AUTHORS README TODO
}
