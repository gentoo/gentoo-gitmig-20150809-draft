# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/qtwitter/qtwitter-0.10.0.ebuild,v 1.2 2009/12/20 09:50:18 hwoarang Exp $

EAPI="2"

inherit qt4

DESCRIPTION="A Qt-based microblogging client"
HOMEPAGE="http://www.qt-apps.org/content/show.php/qTwitter?content=99087"
SRC_URI="http://files.ayoy.net/qtwitter/release/${PV}/src/${P}-src.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="debug"

DEPEND=">=x11-libs/qt-gui-4.5:4
	>=x11-libs/qt-dbus-4.5:4
	>=dev-libs/qoauth-1.0"
RDEPEND="${DEPEND}"

QTWITTER_LANGS="nb_NO pt_BR"
QTWITTER_NOLONGLANGS="ca_ES cs_CZ de_DE es_ES fr_FR it_IT ja_JP pl_PL"

for L in $QTWITTER_LANGS; do
	IUSE="$IUSE linguas_$L"
done
for L in $QTWITTER_NOLONGLANGS; do
	IUSE="$IUSE linguas_${L%_*}"
done

src_prepare() {
	qt4_src_prepare
	echo "CONFIG += nostrip" >> "${S}"/${PN}.pro

	local langs=
	for lingua in $LINGUAS; do
		if has $lingua $QTWITTER_LANGS; then
			langs="$langs ${lingua}"
		else
			for a in $QTWITTER_NOLONGLANGS; do
				if [[ $lingua == ${a%_*} ]]; then
					langs="$langs ${a}"
				fi
			done
		fi
	done

	# remove translations and add only the selected ones
	sed -e '/^ *LANGS/,/^$/s/^/#/' \
		-e "/LANGS =/s/.*/LANGS = ${langs}/" \
		-i translations/translations.pri || die "sed translations failed"
	# fix insecure runpaths
	sed -e '/-Wl,-rpath,\$\${DESTDIR}/d' \
		-i qtwitter-app/qtwitter-app.pro || die "sed rpath failed"
}

src_configure() {
	eqmake4 ${PN}.pro PREFIX="/usr"
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"
	dodoc README CHANGELOG || die "dodoc failed"
}
