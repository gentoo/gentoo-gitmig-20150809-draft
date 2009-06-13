# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/qtwitter/qtwitter-0.7.1.ebuild,v 1.1 2009/06/13 16:35:45 hwoarang Exp $

EAPI="2"

inherit qt4 multilib

DESCRIPTION="A Qt-based client for Twitter and Identi.ca"
HOMEPAGE="http://www.qt-apps.org/content/show.php/qTwitter?content=99087"
SRC_URI="http://files.ayoy.net/qtwitter/release/${PV}/src/${P}-src.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="x11-libs/qt-gui:4"
RDEPEND="${DEPEND}"

QTWITTER_LANGS="pt_BR"
QTWITTER_NOLONGLANGS="ca_ES de_DE es_ES fr_FR ja_JP pl_PL"

for L in $QTWITTER_LANGS; do
	IUSE="$IUSE linguas_$L"
done
for L in $QTWITTER_NOLONGLANGS; do
	IUSE="$IUSE linguas_${L%_*}"
done

src_prepare() {
	echo "CONFIG += nostrip" >> "${S}"/${PN}.pro

	# translations
	local langs=
	for lingua in $LINGUAS; do
		if has $lingua $QTWITTER_LANGS; then
			langs="$langs loc/${PN}_${lingua}.ts"
		else
			for a in $QTWITTER_NOLONGLANGS; do
				if [[ $lingua == ${a%_*} ]]; then
					langs="$langs loc/${PN}_${a}.ts"
				fi
			done
		fi
	done

	# remove translations and add only the selected ones
	sed -i -e '/^ *loc.*\.ts/d' \
	    -e "/^TRANSLATIONS/s:loc.*:${langs}:" \
	    qtwitter-app/qtwitter-app.pro || die "sed failed"
	# first line fixes bug about unsecure runpaths
	# second disables docs installation by make (done by dodoc in install)
	sed -i -e '/-Wl,-rpath,\$\${TOP}/d' \
	    -e '/doc \\/d' \
	    qtwitter-app/qtwitter-app.pro || die "sed failed"

	sed -i "s/\$\${INSTALL_PREFIX}\/lib/\$\${INSTALL_PREFIX}\/$(get_libdir)/" \
		twitterapi/twitterapi.pro urlshortener/urlshortener.pro || die "sed failed"
}

src_configure() {
	eqmake4 ${PN}.pro
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"
	dodoc README CHANGELOG || die "dodoc failed"
}
