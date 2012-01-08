# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/stardict/stardict-3.0.3.ebuild,v 1.1 2012/01/08 17:33:33 ssuominen Exp $

# NOTE: Even though the *.dict.dz are the same as dictd/freedict's files,
#       their indexes seem to be in a different format. So we'll keep them
#       seperate for now.

EAPI=4
inherit eutils

DESCRIPTION="A international dictionary supporting fuzzy and glob style matching"
HOMEPAGE="http://code.google.com/p/stardict-3/"
SRC_URI="http://${PN}-3.googlecode.com/files/${P}.tar.bz2
	pronounce? ( http://${PN}-3.googlecode.com/files/WyabdcRealPeopleTTS.tar.bz2 )
	qqwry? ( mirror://gentoo/QQWry.Dat.bz2 )"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="espeak gnome gucharmap qqwry pronounce spell tools"

COMMON_DEPEND=">=dev-libs/glib-2.16
	dev-libs/libsigc++:2
	sys-libs/zlib
	>=x11-libs/gtk+-2.20:2
	gnome? (
		>=gnome-base/libbonobo-2
		>=gnome-base/libgnome-2
		>=gnome-base/libgnomeui-2
		>=gnome-base/gconf-2
		>=gnome-base/orbit-2
		)
	gucharmap? ( >=gnome-extra/gucharmap-2.22.1:0 )
	spell? ( >=app-text/enchant-1.2 )
	tools? (
		dev-libs/libpcre
		dev-libs/libxml2
		virtual/mysql
		)"
RDEPEND="${COMMON_DEPEND}
	espeak? ( >=app-accessibility/espeak-1.29 )"
DEPEND="${COMMON_DEPEND}
	app-text/docbook-xml-dtd:4.3
	app-text/gnome-doc-utils
	dev-libs/libxslt
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"

RESTRICT="test"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-correct-glib-include.patch \
		"${FILESDIR}"/${P}-entry.patch \
		"${FILESDIR}"/${P}-gcc46.patch
}

src_configure() {
	econf \
		$(use_enable tools) \
		--disable-scrollkeeper \
		$(use_enable spell) \
		$(use_enable gucharmap) \
		--disable-festival \
		$(use_enable espeak) \
		$(use_enable qqwry) \
		--disable-updateinfo \
		$(use_enable gnome gnome-support) \
		--disable-gpe-support \
		--disable-schemas-install
}

src_install() {
	emake DESTDIR="${D}" install

	dodoc dict/doc/{Documentation,FAQ,HACKING,HowToCreateDictionary,Skins,StarDictFileFormat,Translation}

	if use qqwry; then
		insinto /usr/share/stardict/data
		doins ../QQWry.Dat
	fi

	if use pronounce; then
		docinto WyabdcRealPeopleTTS
		dodoc ../WyabdcRealPeopleTTS/{README,readme.txt}
		rm -f ../WyabdcRealPeopleTTS/{README,readme.txt}
		insinto /usr/share
		doins -r ../WyabdcRealPeopleTTS
	fi

	find "${ED}" -name '*.la' -exec rm -f {} +
}

pkg_postinst() {
	elog "Note: festival text to speech (TTS) plugin is not built. To use festival"
	elog 'TTS plugin, please, emerge festival and enable "Use TTS program." at:'
	elog '"Preferences -> Dictionary -> Sound" and fill in "Commandline" with:'
	elog '"echo %s | festival --tts"'
	elog
	elog "You will now need to install stardict dictionary files. If"
	elog "you have not, execute the below to get a list of dictionaries:"
	elog
	elog "  emerge -s stardict-"
}
