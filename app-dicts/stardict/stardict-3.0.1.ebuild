# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/stardict/stardict-3.0.1.ebuild,v 1.3 2008/04/09 17:39:27 nixnut Exp $

inherit gnome2 eutils autotools

# NOTE: Even though the *.dict.dz are the same as dictd/freedict's files,
#       their indexes seem to be in a different format. So we'll keep them
#       seperate for now.

IUSE="festival espeak gnome gucharmap spell"
DESCRIPTION="A GNOME2 international dictionary supporting fuzzy and glob style matching"
HOMEPAGE="http://stardict.sourceforge.net/"
SRC_URI="mirror://sourceforge/stardict/${P}.tar.bz2"

RESTRICT="test"
LICENSE="GPL-2"
SLOT="0"
# when adding keywords, remember to add to stardict.eclass
KEYWORDS="~amd64 ppc ~ppc64 ~sparc ~x86"

DEP="gnome? ( >=gnome-base/libbonobo-2.2.0
		>=gnome-base/libgnome-2.2.0
		>=gnome-base/libgnomeui-2.2.0
		>=gnome-base/gconf-2
		>=gnome-base/orbit-2.6
		app-text/scrollkeeper )
	spell? ( app-text/enchant )
	gucharmap? ( >=gnome-extra/gucharmap-1.4.0 )
	>=sys-libs/zlib-1.1.4
	>=x11-libs/gtk+-2.12"

RDEPEND="${DEP}
	espeak? ( >=app-accessibility/espeak-1.29 )
	festival? ( =app-accessibility/festival-1.96_beta )"

DEPEND="${DEP}
	>=dev-util/intltool-0.22
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-configure.in-EST.diff
	epatch "${FILESDIR}"/${P}-gconf-m4.diff
	AT_M4DIR="m4" eautoreconf
	gnome2_omf_fix
}

src_compile() {
	export PKG_CONFIG=$(type -P pkg-config)
	# Festival plugin crashes, bug 188684. Disable for now.
	G2CONF="$(use_enable gnome gnome-support)
		$(use_enable spell)
		$(use_enable gucharmap)
		$(use_enable espeak espeak)
		--disable-festival
		--disable-advertisement
		--disable-updateinfo"
	gnome2_src_compile
}

pkg_postinst() {
	elog "Note: festival text to speach (TTS) plugin is not built. To use festival"
	elog 'TTS plugin, please, enable "Use TTS program." at:'
	elog '"Preferences -> Dictionary -> Sound" and fill in "Commandline" with:'
	elog '"echo %s | festival --tts"'
	elog
	elog "You will now need to install stardict dictionary files. If"
	elog "you have not, execute the below to get a list of dictionaries:"
	elog
	elog "  emerge -s stardict-"
}
