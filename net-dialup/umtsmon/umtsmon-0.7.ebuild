# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/umtsmon/umtsmon-0.7.ebuild,v 1.1 2007/10/11 10:42:46 mrness Exp $

inherit eutils qt3

DESCRIPTION="UMTSmon is a tool to control and monitor a wireless mobile network card (GPRS, EDGE, WCDMA, UMTS, EV-DO, HSDPA)"
HOMEPAGE="http://umtsmon.sourceforge.net/"
SRC_URI="mirror://sourceforge/umtsmon/${P}.src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="$(qt_min_version 3.3)
	dev-libs/libusb"
RDEPEND="${DEPEND}
	net-dialup/ppp
	sys-apps/pcmciautils"

# for i18n support (probably will appear in version 0.8)
# Supported languages and translated documentation
# Be sure all languages are prefixed with a single space!
#MY_AVAILABLE_LINGUAS=" foo bar"
#IUSE="${IUSE} ${MY_AVAILABLE_LINGUAS// / linguas_}"

src_compile() {
	eqmake3 || die "eqmake3 failed"
	emake || die "emake failed"

	# for i18n support (probably will appear in version 0.8)
	#local MY_LINGUAS="" lang

	#for lang in ${MY_AVAILABLE_LINGUAS} ; do
	#	if use linguas_${lang} ; then
	#		MY_LINGUAS="${MY_LINGUAS} ${lang}"
	#	fi
	#done
	#if [[ -z "${MY_LINGUAS}" ]] ; then
	#	#If no language is selected, install 'em all
	#	MY_LINGUAS="${MY_AVAILABLE_LINGUAS}"
	#fi

	#einfo "Following langpacks will be installed:"
	#einfo "   ${MY_LINGUAS}"

	#for lang in ${MY_LINGUAS}; do
	#	lrelease i18n/umtsmon_${lang}.ts \
	#		|| die "failed to install langpack for ${lang} language"
	#done
}

src_install() {
	dobin umtsmon || die "dobin failed"

	domenu umtsmon.desktop
	doicon images/128

	# for i18n support (probably will appear in version 0.8)
	#insinto /usr/share/umtsmon/i18n
	#doins i18n/*.qm

	dodoc AUTHORS README TODO
}
