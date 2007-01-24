# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/conky/conky-1.4.2.ebuild,v 1.5 2007/01/24 14:01:15 genone Exp $

inherit eutils

DESCRIPTION="Conky is an advanced, highly configurable system monitor for X"
HOMEPAGE="http://conky.sf.net"
SRC_URI="mirror://sourceforge/conky/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="truetype X ipv6 bmpx audacious"

DEPEND_COMMON="
	virtual/libc
	X? (
		|| ( ( x11-libs/libICE
				x11-libs/libXext
				x11-libs/libX11
				x11-libs/libSM
				x11-libs/libXrender
				x11-libs/libXft
				)
				virtual/x11
		)
		truetype? ( >=media-libs/freetype-2 )
		bmpx? ( media-sound/bmpx
				>=sys-apps/dbus-0.35
			)
		audacious? ( media-sound/audacious )
	)"

RDEPEND="${DEPEND_COMMON}"

DEPEND="
	${DEPEND_COMMON}
	X? (
		|| ( ( x11-libs/libXt
				x11-proto/xextproto
				x11-proto/xproto
				)
				virtual/x11
		)
	)
	sys-apps/grep
	sys-apps/sed"

src_compile() {
	local mymake
	if useq ipv6 ; then
		ewarn
		ewarn "You have the ipv6 USE flag enabled.  Please note that"
		ewarn "using the ipv6 USE flag with Conky disables the port"
		ewarn "monitor."
		ewarn
		epause
	else
		mymake="MPD_NO_IPV6=noipv6"
	fi
	local myconf
	myconf="--enable-double-buffer --enable-own-window --enable-proc-uptime \
		--enable-mpd --enable-mldonkey"
	econf \
		${myconf} \
		--disable-xmms --disable-infopipe \
		$(use_enable truetype xft) \
		$(use_enable X x11) \
		$(use_enable bmpx) \
		$(use_enable audacious) \
		$(use_enable !ipv6 portmon) || die "econf failed"
	emake ${mymake} || die "compile failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog AUTHORS README doc/conkyrc.sample
	dohtml doc/docs.html doc/config_settings.html doc/variables.html
}

pkg_postinst() {
	elog 'Default configuration file is "~/.conkyrc"'
	elog "you can find a sample configuration file in"
	elog "/usr/share/doc/${PF}/conkyrc.sample.gz"
	elog
	elog "For more info on Conky's new features,"
	elog "please look at the README and ChangeLog:"
	elog "/usr/share/doc/${PF}/README.gz"
	elog "/usr/share/doc/${PF}/ChangeLog.gz"
	elog "There are also pretty html docs available"
	elog "on Conky's site or in /usr/share/doc/${PF}"
	elog
	elog "Also see http://www.gentoo.org/doc/en/conky-howto.xml"
	elog
	elog "Check out app-vim/conky-syntax for conkyrc"
	elog "syntax highlighting in Vim"
	elog
}
