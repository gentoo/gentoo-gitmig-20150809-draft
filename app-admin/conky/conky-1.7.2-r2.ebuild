# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/conky/conky-1.7.2-r2.ebuild,v 1.11 2010/11/06 01:42:29 rafaelmartins Exp $

EAPI="2"

inherit eutils

DESCRIPTION="An advanced, highly configurable system monitor for X"
HOMEPAGE="http://conky.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-3 BSD LGPL-2.1 MIT"
SLOT="0"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"
IUSE="alsa apcupsd audacious curl debug eve hddtemp imlib iostats lua lua-cairo lua-imlib math moc mpd nano-syntax nvidia +portmon rss thinkpad truetype vim-syntax weather-metar weather-xoap wifi X"
# currently removed openmp, see
# http://git.omp.am/?p=conky.git;a=commit;h=670e9a0eb15ed3bc384ae0154d3c09de691e390c

DEPEND_COMMON="
	X? (
		imlib? ( media-libs/imlib2 )
		lua-cairo? ( >=dev-lua/toluapp-1.0.93 x11-libs/cairo[X] )
		lua-imlib? ( >=dev-lua/toluapp-1.0.93 media-libs/imlib2 )
		nvidia? ( media-video/nvidia-settings )
		truetype? ( x11-libs/libXft >=media-libs/freetype-2 )
		x11-libs/libX11
		x11-libs/libXdamage
		x11-libs/libXext
	)
	alsa? ( media-libs/alsa-lib )
	audacious? ( >=media-sound/audacious-1.5 )
	curl? ( net-misc/curl )
	eve? ( net-misc/curl dev-libs/libxml2 )
	portmon? ( dev-libs/glib )
	lua? ( >=dev-lang/lua-5.1 )
	rss? ( dev-libs/libxml2 net-misc/curl dev-libs/glib )
	wifi? ( net-wireless/wireless-tools )
	weather-metar? ( net-misc/curl )
	weather-xoap? ( dev-libs/libxml2 net-misc/curl )
	sys-libs/zlib
	virtual/libiconv
	"
#	openmp? ( >=sys-devel/gcc-4.3[openmp] )
RDEPEND="
	${DEPEND_COMMON}
	apcupsd? ( sys-power/apcupsd )
	hddtemp? ( app-admin/hddtemp )
	moc? ( media-sound/moc )
	nano-syntax? ( app-editors/nano )
	vim-syntax? ( || ( app-editors/vim app-editors/gvim ) )
	"
DEPEND="
	${DEPEND_COMMON}
	dev-util/pkgconfig
	"

src_configure() {
	local myconf
	if use X; then
		myconf="--enable-x11 --enable-double-buffer --enable-xdamage"
		myconf="${myconf} --enable-own-window"
		myconf="${myconf} $(use_enable imlib imlib2) $(use_enable lua-cairo)"
		myconf="${myconf} $(use_enable lua-imlib lua-imlib2)"
		myconf="${myconf}  $(use_enable nvidia) $(use_enable truetype xft)"
	else
		myconf="--disable-x11 --disable-own-window"
		myconf="${myconf} --disable-imlib --disable-lua-cairo --disable-lua-imlib"
		myconf="${myconf} --disable-nvidia --disable-xft"
	fi

	econf \
		${myconf} \
		$(use_enable alsa) \
		$(use_enable apcupsd) \
		$(use_enable audacious) \
		$(use_enable curl) \
		$(use_enable debug) \
		$(use_enable eve) \
		$(use_enable hddtemp) \
		$(use_enable iostats) \
		$(use_enable lua) \
		$(use_enable thinkpad ibm) \
		$(use_enable math) \
		$(use_enable moc) \
		$(use_enable mpd) \
		$(use_enable portmon) \
		$(use_enable rss) \
		$(use_enable weather-metar) \
		$(use_enable weather-xoap) \
		$(use_enable wifi wlan)
#		$(use_enable openmp) \
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog AUTHORS TODO || die "dodoc failed"
	dohtml doc/docs.html doc/config_settings.html doc/variables.html \
		|| die "dohtml failed"

	if use vim-syntax; then
		insinto /usr/share/vim/vimfiles/ftdetect
		doins "${S}"/extras/vim/ftdetect/conkyrc.vim || die "doins failed"

		insinto /usr/share/vim/vimfiles/syntax
		doins "${S}"/extras/vim/syntax/conkyrc.vim|| die "doins failed"
	fi

	if use nano-syntax; then
		insinto /usr/share/nano/
		doins "${S}"/extras/nano/conky.nanorc|| die "doins failed"
	fi
}

pkg_postinst() {
	elog "You can find a sample configuration file at"
	elog "${ROOT%/}/etc/conky/conky.conf. To customize, copy"
	elog "it to ~/.conkyrc and edit it to your liking."
	elog
	elog "For more info on Conky's new features please look at"
	elog "the Changelog in ${ROOT%/}/usr/share/doc/${PF}"
	elog "There are also pretty html docs available"
	elog "on Conky's site or in ${ROOT%/}/usr/share/doc/${PF}/html"
	elog
	elog "Also see http://www.gentoo.org/doc/en/conky-howto.xml"
	elog
	elog "Vim syntax highlighting for conkyrc now enabled with"
	elog "USE=vim-syntax, for Nano with USE=nano-syntax"
	elog
}
