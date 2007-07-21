# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/terminal/terminal-0.2.6_p25931.ebuild,v 1.5 2007/07/21 16:55:39 drac Exp $

inherit xfce44

xfce44

MY_P="${P/t/T}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Terminal for Xfce desktop environment, based on vte library."
HOMEPAGE="http://www.xfce.org/projects/terminal"
SRC_URI="http://dev.gentooexperimental.org/~drac/distfiles/${MY_P}.tar.bz2"

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ~ppc ~ppc64 ~sparc x86 ~x86-fbsd"
IUSE="dbus debug startup-notification doc"

RESTRICT="test"

RDEPEND=">=dev-libs/glib-2.6
	>=x11-libs/gtk+-2.6
	media-libs/fontconfig
	media-libs/freetype
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXft
	x11-libs/libXrender
	startup-notification? ( x11-libs/startup-notification )
	dbus? ( dev-libs/dbus-glib )
	>=x11-libs/vte-0.11.11
	>=xfce-extra/exo-0.3.2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	doc? ( dev-libs/libxslt )"

XFCE_CONFIG="${XFCE_CONFIG} $(use_enable dbus) $(use_enable doc xsltproc) \
	--enable-maintainer-mode"

DOCS="AUTHORS ChangeLog HACKING NEWS README THANKS TODO"
