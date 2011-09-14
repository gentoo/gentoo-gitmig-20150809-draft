# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/google-chrome/google-chrome-14.0.835.163_beta101024.ebuild,v 1.1 2011/09/14 23:40:55 floppym Exp $

EAPI="4"

inherit eutils fdo-mime gnome2-utils multilib pax-utils

MY_PN="${PN}-beta"
MY_P="${MY_PN}_${PV/_beta/-r}"

DESCRIPTION="The web browser from Google"
HOMEPAGE="http://www.google.com/chrome"
SRC_BASE="http://dl.google.com/linux/chrome/deb/pool/main/g/${MY_PN}/${MY_P}_"
SRC_URI="amd64? ( ${SRC_BASE}amd64.deb ) x86? ( ${SRC_BASE}i386.deb )"

LICENSE="google-chrome"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE="+plugins"
RESTRICT="mirror"

# en_US is ommitted on purpose from the list below. It must always be available.
LANGS="am ar bg bn ca cs da de el en_GB es es_LA et fa fi fil fr gu he hi hr
hu id it ja kn ko lt lv ml mr nb nl pl pt_BR pt_PT ro ru sk sl sr sv sw ta te th
tr uk vi zh_CN zh_TW"
for lang in ${LANGS}; do
	    IUSE+=" linguas_${lang}"
done

DEPEND="!app-arch/deb2targz"
RDEPEND="app-arch/bzip2
	app-misc/ca-certificates
	media-libs/alsa-lib
	dev-libs/atk
	dev-libs/dbus-glib
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/libxslt
	dev-libs/nspr
	dev-libs/nss
	gnome-base/gconf:2
	media-libs/fontconfig
	media-libs/freetype
	net-print/cups
	media-libs/libpng:1.2
	sys-apps/dbus
	>=sys-devel/gcc-4.4.0[-nocxx]
	sys-libs/zlib
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:2
	x11-libs/libXScrnSaver
	x11-libs/libX11
	x11-libs/libXrender
	x11-libs/libXext
	x11-libs/pango
	x11-misc/xdg-utils"

QA_PREBUILT="*"
S="${WORKDIR}"

# Chromium uses different names for some langs,
# return Chromium name corresponding to a Gentoo lang.
chromium_lang() {
	if [[ "$1" == "es_LA" ]]; then
		echo "es_419"
	else
		echo "$1"
	fi
}

src_unpack() {
	default
	unpack ./data.tar.lzma || die
}

src_prepare() {
	CHROME_HOME="opt/google/chrome/"

	pax-mark m ${CHROME_HOME}chrome || die
	rm -rf usr/share/menu || die
	mv usr/share/doc/${PN} usr/share/doc/${PF} || die

	# Support LINGUAS, bug #332751.
	cd "${CHROME_HOME}locales" || die
	local pak
	for pak in *.pak; do
		local pakbasename="$(basename ${pak})"
		local pakname="${pakbasename%.pak}"
		local langname="${pakname//-/_}"

		# Do not issue warning for en_US locale. This is the fallback
		# locale so it should always be installed.
		if [[ "${langname}" == "en_US" ]]; then
			continue
		fi

		local found=false
		local lang
		for lang in ${LANGS}; do
			local crlang="$(chromium_lang ${lang})"
			if [[ "${langname}" == "${crlang}" ]]; then
				found=true
				break
			fi
		done
		if ! $found; then
			ewarn "LINGUAS warning: no ${langname} in LANGS"
		fi
	done
	local lang
	for lang in ${LANGS}; do
		local crlang="$(chromium_lang ${lang})"
		local pakfile="${crlang//_/-}.pak"
		if [ ! -f "${pakfile}" ]; then
			ewarn "LINGUAS warning: no .pak file for ${lang} (${pakfile} not found)"
		fi
		if ! use linguas_${lang}; then
			rm "${pakfile}" || die
		fi
	done

}

src_install() {
	mv opt usr "${D}" || die

	fperms u+s "/${CHROME_HOME}chrome-sandbox" || die

	if use plugins ; then
		local args='"$@"'
		local plugins="/usr/$(get_libdir)/nsbrowser/plugins"
		sed -e "s:${args}:--extra-plugin-dir=\"${plugins}\" \\0:" \
			-i "${D}${CHROME_HOME}google-chrome" || die
	fi

	domenu "${D}${CHROME_HOME}google-chrome.desktop" || die
	local size
	for size in 16 22 24 32 48 64 128 256 ; do
		insinto /usr/share/icons/hicolor/${size}x${size}/apps
		newins "${D}${CHROME_HOME}product_logo_${size}.png" google-chrome.png
	done
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}
