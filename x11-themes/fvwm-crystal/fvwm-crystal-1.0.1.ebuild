# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/fvwm-crystal/fvwm-crystal-1.0.1.ebuild,v 1.7 2004/03/25 19:14:15 taviso Exp $

DESCRIPTION="A very nice and powerful theme for FVWM"
HOMEPAGE="http://fvwm-crystal.linuxpl.org/"
SRC_URI="ftp://ftp.linuxpl.org/fvwm-crystal/tarballs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="xmms"

RDEPEND=">=x11-wm/fvwm-2.5.8
	xmms? ( media-plugins/xmms-shell
		>=media-sound/xmms-1.2.7
		media-plugins/xmms-find )
	x11-misc/xdaliclock
	x11-terms/aterm
	x11-misc/habak
	media-sound/aumix"

# http://fvwm-crystal.linuxpl.org/info.en.html also reccomends:
# app-misc/rox
# media-gfx/scrot
# x11-misc/xlockmore

DEPEND="${RDEPEND} sys-devel/automake"

src_unpack() {
	unpack ${A}
	cd ${S}; epatch ${FILESDIR}/fvwm-crystal-fvwm-version-check.diff

	# cp: cannot stat `INSTALL.CVS': No such file or directory
	# cp: cannot stat `INSTALL-PL.CVS': No such file or directory
	# make: *** [install] Error 1
	ebegin "Updating Makefile"
	automake || die
	eend $?

	# configure: error:
	# You have fvwm-2.5.10, which is not up to date
	# You need at least fvwm-2.5.8
	ebegin "Updating configure script"
	autoconf || die
	eend $?
}

src_compile() {
	# doesnt make any difference with this version but if xmms
	# support controls any features in future, we shouldnt leave
	# it up to configure to enable it.
	#
	#if ! use xmms; then
	#	sed -i 's#test -z "$XMMS_SHELL";#false;#g' ${S}/configure.in
	#	sed -i 's#test -z "$XMMS";#false;#g' ${S}/configure.in
	#	autoconf || die
	#fi

	econf || die
	emake || die
}

src_install() {
	einstall || die
}

pkg_postinst() {
	einfo ""
	einfo "users should run fvwm-crystal.install to configure fvwm-crystal"
	einfo ""
	einfo ""
	einfo "fvwm-crystal authors also reccomend the following applications:"
	einfo ""
	einfo "	app-misc/rox"
	einfo "	media-gfx/scrot"
	einfo "	x11-misc/xlockmore"
	einfo ""
}

