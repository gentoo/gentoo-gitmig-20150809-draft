# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/pppconfig/pppconfig-2.3.11-r2.ebuild,v 1.5 2006/03/12 21:17:53 mrness Exp $

DESCRIPTION="A text menu based utility for configuring ppp."
SRC_URI="http://http.us.debian.org/debian/pool/main/p/pppconfig/${PN}_${PV}.tar.gz"
HOMEPAGE="http://http.us.debian.org/debian/pool/main/p/pppconfig/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ppc x86"
IUSE="nls"

RDEPEND="net-dialup/ppp
	dev-util/dialog"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

S="${WORKDIR}/${PN}"

src_install () {
	dodir /etc/chatscripts /etc/ppp/resolv
	dosbin 0dns-down 0dns-up dns-clean
	newsbin pppconfig pppconfig.real
	dosbin "${FILESDIR}/pppconfig"
	doman pppconfig.8
	dodoc debian/{copyright,changelog}

	if use nls; then
		cd "${S}/po"
		local MY_LOCALE_LANGUAGES lang

		if [ -n "${LINGUAS}" ]; then #install messages only in user-selected languages
			local lang
			for lang in ${LINGUAS}; do
				[ -f "${lang}.po" ] && \
					MY_LOCALE_LANGUAGES="${MY_LOCALE_LANGUAGES} ${lang}"
			done
		fi
		if [ -z "${MY_LOCALE_LANGUAGES}" ]; then #install messages in all available languages
			local f
			for f in *.po; do
				MY_LOCALE_LANGUAGES="${MY_LOCALE_LANGUAGES} ${f%.po}"
			done
		fi
		einfo "Locale messages will be installed for following languages:"
		einfo "   ${MY_LOCALE_LANGUAGES}"

		for lang in ${MY_LOCALE_LANGUAGES}; do
			msgfmt -o ${lang}.mo ${lang}.po && \
				insinto /usr/share/locale/${lang}/LC_MESSAGES && \
				newins ${lang}.mo pppconfig.mo || \
					die "failed to install locale messages for ${lang} language"
		done
	fi
}
