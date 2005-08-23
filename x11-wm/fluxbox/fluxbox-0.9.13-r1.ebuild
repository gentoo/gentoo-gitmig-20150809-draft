# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/fluxbox/fluxbox-0.9.13-r1.ebuild,v 1.11 2005/08/23 22:01:55 agriffis Exp $

inherit eutils

IUSE="nls xinerama truetype kde gnome imlib disablexmb"

DESCRIPTION="Fluxbox is an X11 window manager featuring tabs and an iconbar"
SRC_URI="mirror://sourceforge/fluxbox/${P}.tar.bz2"
HOMEPAGE="http://www.fluxbox.org"

# Please note that USE="kde gnome" simply adds support for the respective
# protocols, and does not depend on external libraries. They do, however,
# make the binary a fair bit bigger, so we don't want to turn them on unless
# the user actually wants them.

RDEPEND="virtual/x11
	truetype? ( media-libs/freetype )
	nls? ( sys-devel/gettext )
	imlib? ( >=media-libs/imlib2-1.2.0 )
	!<x11-themes/fluxbox-styles-fluxmod-20040809-r1"
DEPEND=">=sys-devel/autoconf-2.52
		${RDEPEND}"
PROVIDE="virtual/blackbox"

SLOT="0"
LICENSE="MIT"
KEYWORDS="alpha amd64 hppa ia64 mips ppc ~ppc-macos ppc64 sparc x86"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# We need to be able to include directories rather than just plain
	# files in menu [include] items. This patch will allow us to do clever
	# things with style ebuilds.
	epatch ${FILESDIR}/${PV}/${P}-our-styles-go-over-here.patch

	# Fix for systray icon problems from upstream r4023, bug #92915.
	epatch ${FILESDIR}/${PV}/${P}-4023-overlapping-icons-are-bad-92915.patch

	# Add in the Gentoo -r number to fluxbox -version output.
	if [[ "${PR}" == "r0" ]] ; then
		suffix="gentoo"
	else
		suffix="gentoo-${PR}"
	fi
	sed -i \
		-e "s~\(__fluxbox_version .@VERSION@\)~\1-${suffix}~" \
		version.h.in || die "version sed failed"

	# Turn on aa by default if possible. Fluxbox fonts are really frickin'
	# broken, we'll do what we can to make it less painful by default.
	use truetype 1>/dev/null && \
		echo "session.screen0.antialias: true" >> data/init.in
}

src_compile() {
	export PKG_CONFIG_PATH=/usr/X11R6/lib/pkgconfig:/usr/lib/pkgconfig

	econf \
		$(use_enable nls) \
		$(use_enable xinerama) \
		$(use_enable truetype xft) \
		$(use_enable kde) \
		$(use_enable gnome) \
		$(use_enable !disablexmb xmb) \
		$(use_enable imlib imlib2) \
		--sysconfdir=/etc/X11/${PN} \
		--with-style=/usr/share/fluxbox/styles/Emerge \
		${myconf} || die "configure failed"

	emake || die "make failed"

	ebegin "Creating a menu file (may take a while)"
	mkdir -p "${T}/home/.fluxbox" || die "mkdir home failed"
	MENUFILENAME="${S}/data/menu" MENUTITLE="Fluxbox ${PV}" \
		CHECKINIT="no. go away." HOME="${T}/home" \
		${S}/util/fluxbox-generate_menu -is -ds \
		|| die "menu generation failed"
	eend $?
}

src_install() {
	dodir /usr/share/fluxbox
	make DESTDIR=${D} install || die "make install failed"
	dodoc README* AUTHORS TODO* COPYING ChangeLog NEWS

	dodir /usr/share/xsessions
	insinto /usr/share/xsessions
	doins ${FILESDIR}/${PN}.desktop

	dodir /etc/X11/Sessions
	echo "/usr/bin/startfluxbox" > ${D}/etc/X11/Sessions/fluxbox
	fperms a+x /etc/X11/Sessions/fluxbox

	dodir /usr/share/fluxbox/menu.d

	# Styles menu framework
	dodir /usr/share/fluxbox/menu.d/styles
	insinto /usr/share/fluxbox/menu.d/styles
	doins ${FILESDIR}/0.9.10/styles-menu-fluxbox || die
	doins ${FILESDIR}/0.9.10/styles-menu-commonbox || die
	doins ${FILESDIR}/0.9.10/styles-menu-user || die
}

pkg_postinst() {
	einfo "As of fluxbox 0.9.10-r3, we are using an improved system for"
	einfo "handling styles in the menu. To take advantage of this, use"
	einfo "the following for your menu styles section:"
	einfo
	einfo "    [submenu] (Styles) {Select a Style}"
	einfo "        [include] (/usr/share/fluxbox/menu.d/styles/)"
	einfo "    [end]"
	einfo
	einfo "If you use fluxbox-generate_menu or the default global fluxbox"
	einfo "menu file, this will already be present."
	einfo
	ewarn "Note that menumaker and similar utilities do *not* support"
	ewarn "this out of the box."
	einfo
	einfo "If you experience font problems, or if fluxbox takes a very"
	einfo "long time to start up, please try the 'disablexmb' USE flag."
	einfo "If that fails, please report bugs upstream."
	epause
}
