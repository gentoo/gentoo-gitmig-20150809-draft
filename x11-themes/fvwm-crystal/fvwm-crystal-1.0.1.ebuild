# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header:

DESCRIPTION="A very nice and powerful theme for FVWM"
HOMEPAGE="http://fvwm-crystal.linuxpl.org/"
SRC_URI="ftp://ftp.linuxpl.org/fvwm-crystal/tarballs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="xmms"

RDEPEND=">=x11-wm/fvwm-2.5.9
	xmms? ( media-plugins/xmms-shell
		>=media-sound/xmms-1.2.7 )
	x11-misc/xdaliclock
	x11-terms/aterm
	x11-misc/habak
	media-sound/aumix"

DEPEND="${RDEPEND} sys-devel/automake"

src_compile() {
	# cp: cannot stat `INSTALL.CVS': No such file or directory
	# cp: cannot stat `INSTALL-PL.CVS': No such file or directory
	# make: *** [install] Error 1
	ebegin "Updating Makefile..."
	automake || die
	eend $?

	econf --prefix=${D} || die
	emake || die
}

src_install() {
	einstall || die
}

pkg_postinst() {
	einfo  "users should run fvwm-crystal.install to configure fvwm-crystal"
}

