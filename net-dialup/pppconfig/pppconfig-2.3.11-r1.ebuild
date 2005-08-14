# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/pppconfig/pppconfig-2.3.11-r1.ebuild,v 1.2 2005/08/14 18:23:19 metalgod Exp $

DESCRIPTION="A text menu based utility for configuring ppp."
SRC_URI="http://http.us.debian.org/debian/pool/main/p/pppconfig/${PN}_${PV}.tar.gz"
HOMEPAGE="http://http.us.debian.org/debian/pool/main/p/pppconfig/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="nls"

DEPEND="net-dialup/ppp
	dev-util/dialog
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}

	if use nls; then
		declare MY_LOCALE_LANGUAGES
		cd ${S}/po

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
		einfo "Locale messages will be installed in following languages:"
		einfo "   ${MY_LOCALE_LANGUAGES}"
	fi
}

src_compile() {
	if use nls; then
		local lang
		for lang in ${MY_LOCALE_LANGUAGES}; do
			msgfmt -o po/${lang}.mo po/${lang}.po || \
				die "failed to compile ${lang}.mo"
		done
	fi
}

src_install () {
	dodir /etc/chatscripts /etc/ppp/resolv
	dosbin 0dns-down 0dns-up dns-clean
	newsbin pppconfig pppconfig.real
	dosbin ${FILESDIR}/pppconfig
	doman pppconfig.8
	dodoc debian/{copyright,changelog}

	if use nls; then
		local lang
		for lang in ${MY_LOCALE_LANGUAGES}; do
			insinto /usr/share/locale/${lang}/LC_MESSAGES
			newins po/${lang}.mo pppconfig.mo
		done
	fi
}
