# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/beryl/beryl-0.1.2.ebuild,v 1.2 2006/12/17 19:41:37 drizzt Exp $

inherit autotools

DESCRIPTION="Beryl window manager for AiGLX and XGL (meta)"
HOMEPAGE="http://beryl-project.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="=x11-plugins/beryl-plugins-0.1.2
	=x11-wm/emerald-0.1.2
	=x11-misc/beryl-settings-0.1.2
	=x11-misc/beryl-manager-0.1.2"

pkg_setup() {
	if has_version ">=x11-libs/cairo-1.2.2" && ! built_with_use x11-libs/cairo X; then
		einfo "Please re-emerge >=x11-libs/cairo-1.2.2 with the X USE flag set"
		die "Please emerge >=x11-libs/cairo-1.2.2 with the X flag set"
	fi
}

