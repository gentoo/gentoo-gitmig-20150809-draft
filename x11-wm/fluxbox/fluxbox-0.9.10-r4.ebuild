# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/fluxbox/fluxbox-0.9.10-r4.ebuild,v 1.3 2004/10/23 05:39:52 mr_bones_ Exp $

inherit eutils

IUSE="nls xinerama truetype kde gnome bigger-fonts"

DESCRIPTION="Fluxbox is an X11 window manager featuring tabs and an iconbar"
SRC_URI="mirror://sourceforge/fluxbox/${P}.tar.bz2
	mirror://gentoo/${P}-biiiiig-update.patch.bz2"
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
KEYWORDS="~x86 ~ppc ~sparc ~amd64 ~alpha ~hppa ~ia64 ~mips ~ppc64 ~ppc-macos"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Branch update from upstream CVS
	epatch ${WORKDIR}/${PN}-${PV}-biiiiig-update.patch

	# Fix locales, see discussion in bug 65803.
	epatch ${FILESDIR}/${PV}/${PN}-${PV}-eat-this-setlocale.patch

	# Some fluxbox-generate_menu things. These are ciaranm's fault...
	epatch ${FILESDIR}/${PV}/${PN}-${PV}-posix-on-toast.patch
	epatch ${FILESDIR}/${PV}/${PN}-${PV}-my-term-is-better-than-your-term.patch
	epatch ${FILESDIR}/${PV}/${PN}-${PV}-editor-thingies.patch
	epatch ${FILESDIR}/${PV}/${PN}-${PV}-all-about-me.patch

	# We need to be able to include directories rather than just plain
	# files in menu [include] items. This patch will allow us to do clever
	# things with style ebuilds.
	epatch ${FILESDIR}/${PV}/${PN}-${PV}-fancy-gentoo-styledirs.patch

	# Add in the Gentoo -r number to fluxbox -version output.
	sed -i \
		-e "s~\(__fluxbox_version .@VERSION@\)~\1-gentoo${PR:+-${PR}}~" \
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
		use bigger-fonts 1>/dev/null && ( sed -i \
			-e 's~\([fF]ont:[ \t]\+[a-zA-Z]\+-\)[789]~\110~' \
			${style} || die "sed voodoo failed (insufficient goats?)" )

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

	# Our megapatch means we need to regen this little lot...
	ebegin "Updating autotools-generated files"
	aclocal -I . || die "aclocal failed"
	autoheader || die "autoheader failed"
	automake -a || die "automake failed"
	autoconf || die "autoconf failed"
	eend $?

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
	einfo " "
	if has_version '<x11-wm/fluxbox-0.9.10-r3' ; then
		ewarn "You must restart fluxbox before using the [include] /directory/"
		ewarn "feature if you are upgrading from an older fluxbox!"
		ewarn " "
	fi
	ewarn "Be warned that anything involving XComposite is extremely "
	ewarn "experimental. Please don't report bugs unless they also occur "
	ewarn "with XComposite disabled."
	ewarn " "
	epause
}
