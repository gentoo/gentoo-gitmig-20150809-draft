# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/fluxbox/fluxbox-0.9.12-r1.ebuild,v 1.6 2005/03/19 09:46:57 kloeri Exp $

inherit eutils

IUSE="nls xinerama truetype kde gnome imlib bigger-fonts disablexmb"

DESCRIPTION="Fluxbox is an X11 window manager featuring tabs and an iconbar"
# SourceForge mirrors are broken. Yay!
# SRC_URI="mirror://sourceforge/fluxbox/${P}.tar.bz2"
SRC_URI="http://www.fluxbox.org/download/${P}.tar.bz2"
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
KEYWORDS="x86 ppc sparc amd64 alpha ~hppa ~ia64 ~mips ppc64 ~ppc-macos"

src_unpack() {
	unpack ${A}
	cd ${S}

	# We need to be able to include directories rather than just plain
	# files in menu [include] items. This patch will allow us to do clever
	# things with style ebuilds.
	epatch ${FILESDIR}/${PV}/${P}-our-styles-go-over-here.patch

	# menu generator things
	epatch ${FILESDIR}/${PV}/${P}-you-got-mail.patch
	epatch ${FILESDIR}/${PV}/${P}-sweet-sweet-music.patch
	epatch ${FILESDIR}/${PV}/${P}-vi-sucks-use-vim.patch
	epatch ${FILESDIR}/${PV}/${P}-pretty-eye-candy.patch

	# fixes
	epatch ${FILESDIR}/${PV}/${P}-3853-zero-is-not-null.patch
	epatch ${FILESDIR}/${PV}/${P}-3853-zero-is-still-not-null.patch
	epatch ${FILESDIR}/${PV}/${P}-3856-hide-and-seek-is-bad.patch
	epatch ${FILESDIR}/${PV}/${P}-3860-menu-backups.patch

	# Add in the Gentoo -r number to fluxbox -version output.
	if [[ "${PR}" == "r0" ]] ; then
		suffix="gentoo"
	else
		suffix="gentoo-${PR}"
	fi
	sed -i \
		-e "s~\(__fluxbox_version .@VERSION@\)~\1-${suffix}~" \
		version.h.in || die "version sed failed"

	# Use a less fugly default theme
	sed -i \
		-e 's~styles/Meta~styles/Emerge~' data/init.in

	# Turn on aa by default if possible. Fluxbox fonts are really frickin'
	# broken, we'll do what we can to make it less painful by default.
	use truetype 1>/dev/null && \
		echo "session.screen0.antialias: true" >> data/init.in

	ebegin "Fixing style fonts..."
	for style in data/styles/* ; do
		[[ -d "${style}" ]] && style=${style}/theme.cfg
		[[ -f "${style}" ]] || die "waah! ${style} doesn't exist"

		# Make fonts more readable if we use bigger-fonts
		if use bigger-fonts 1>/dev/null ; then
			sed -i \
				-e 's~\([fF]ont:[ \t]\+[a-zA-Z]\+-\)[789]~\110~' \
				${style} || die "sed voodoo failed (insufficient goats?)"
		fi

		# We don't have a reliable sans font alias, change it to lucidasans.
		# That might not work either, but it's more likely...
		sed -i \
			-e 's~\([ \t:]\)sans\(-\|$\)~\1lucidasans\2~' \
			${style} || die "sed voodoo failed (not a full moon)"
	done
	eend $?
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
		${myconf} || die "configure failed"

	emake || die "make failed"
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
	einfo " "
	einfo "    [submenu] (Styles) {Select a Style}"
	einfo "        [include] (/usr/share/fluxbox/menu.d/styles/)"
	einfo "    [end]"
	einfo " "
	einfo "If you use fluxbox-generate_menu or the default global fluxbox"
	einfo "menu file, this will already be present."
	einfo " "
	if has_version '<x11-wm/fluxbox-0.9.10-r3' ; then
		ewarn "You must restart fluxbox before using the [include] /directory/"
		ewarn "feature if you are upgrading from an older fluxbox!"
		ewarn " "
	fi
	einfo "If you experience font problems, or if fluxbox takes a very"
	einfo "long time to start up, please try the 'disablexmb' USE flag."
	einfo "If that fails, please report bugs upstream."
	epause
}
