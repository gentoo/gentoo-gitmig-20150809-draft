# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/fluxbox/fluxbox-0.9.10-r3.ebuild,v 1.8 2004/10/17 11:36:17 absinthe Exp $

inherit eutils

IUSE="nls xinerama truetype kde gnome"

DESCRIPTION="Fluxbox is an X11 window manager featuring tabs, an iconbar and KDE/GNOME protocol support"
SRC_URI="mirror://sourceforge/fluxbox/${P}.tar.bz2"
HOMEPAGE="http://www.fluxbox.org"

# Please note that USE="kde gnome" simply adds support for the respective
# protocols, and does not depend on external libraries. They do, however,
# make the binary a fair bit bigger, so we don't want to turn them on unless
# the user actually wants them.

RDEPEND="virtual/x11
	truetype? ( media-libs/freetype )
	nls? ( sys-devel/gettext )
	!<x11-themes/fluxbox-styles-fluxmod-20040809-r1"
DEPEND=">=sys-devel/autoconf-2.52
		${RDEPEND}"
PROVIDE="virtual/blackbox"

SLOT="0"
LICENSE="MIT"
KEYWORDS="x86 ppc sparc amd64 ~alpha hppa ~ia64 ~mips ~ppc64 ~macos ~ppc-macos"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Fix crashy badness on amd64. From upstream.
	epatch ${FILESDIR}/${PV}/${PN}-${PV}-amd64-font-fix.patch

	# Other crash fixes. Pulled from -cvs upstream.
	epatch ${FILESDIR}/${PV}/${PN}-${PV}-windowmenu-crash.patch
	epatch ${FILESDIR}/${PV}/${PN}-${PV}-workspacemenu-crash.patch

	# Make xcomposite not screw things up. From upstream.
	epatch ${FILESDIR}/${PV}/${PN}-${PV}-make-pretty-eye-candy-work.patch

	# Scary X error updates from upstream.
	epatch ${FILESDIR}/${PV}/${PN}-${PV}-misc-updates.patch
	epatch ${FILESDIR}/${PV}/${PN}-${PV}-super-x-voodoo.patch
	epatch ${FILESDIR}/${PV}/${PN}-${PV}-super-x-voodoo-two.patch

	# Some fluxbox-generate_menu things. These are ciaranm's fault...
	epatch ${FILESDIR}/${PV}/${PN}-${PV}-posix-on-toast.patch
	epatch ${FILESDIR}/${PV}/${PN}-${PV}-my-term-is-better-than-your-term.patch
	epatch ${FILESDIR}/${PV}/${PN}-${PV}-editor-thingies.patch
	epatch ${FILESDIR}/${PV}/${PN}-${PV}-all-about-me.patch

	# We need to be able to include directories rather than just plain
	# files in menu [include] items. This patch will allow us to do clever
	# things with style ebuilds.
	epatch ${FILESDIR}/${PV}/${PN}-${PV}-menu-include-directories.patch
	epatch ${FILESDIR}/${PV}/${PN}-${PV}-fancy-gentoo-styledirs.patch

	# Since we're patching heavily, make fluxbox -version say what we're
	# really running.
	sed -i \
		-e "s~\(__fluxbox_version .@VERSION@\)~\1${PR:+-gentoo-${PR}}~" \
		version.h.in || die "version sed failed"
}

src_compile() {
	export PKG_CONFIG_PATH=/usr/X11R6/lib/pkgconfig:/usr/lib/pkgconfig
	econf \
		`use_enable nls` \
		`use_enable xinerama` \
		`use_enable truetype xft` \
		`use_enable kde` \
		`use_enable gnome` \
		--sysconfdir=/etc/X11/${PN} \
		${myconf} || die "configure failed"

	emake || die "make failed"
}

src_install() {
	dodir /usr/share/fluxbox
	make DESTDIR=${D} install || die "make install failed"
	dodoc README* AUTHORS TODO* COPYING

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
	doins ${FILESDIR}/${PV}/styles-menu-fluxbox
	doins ${FILESDIR}/${PV}/styles-menu-commonbox
	doins ${FILESDIR}/${PV}/styles-menu-user
}

pkg_postinst() {
	einfo "As of fluxbox 0.9.10-r3, we are using an improved system for"
	einfo "handling styles in the menu. To take advantage of this, use"
	einfo "the following for your menu styles section:"
	einfo " "
	einfo "    [submenu] (Styles) {Select a Style}"
	einfo "        [include] (/usr/share/fluxbox/menu.d/styles/)"
	einfo "    [end]"
	einfo " "
	einfo "If you use fluxbox-generate_menu or the default global fluxbox"
	einfo "menu file, this will already be present."
	ewarn " "
	ewarn "You must restart fluxbox before using the [include] /directory/"
	ewarn "feature!"
	ewarn " "
	epause
}
