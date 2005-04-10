# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/engage/engage-0.0.9.20050220.ebuild,v 1.3 2005/04/10 21:02:56 vapier Exp $

ECVS_MODULE="misc/engage"
EHACKAUTOGEN=yes
inherit enlightenment

DESCRIPTION="nice bar thingy"

IUSE="xinerama"

DEPEND=">=x11-libs/esmart-0.9.0
	>=media-libs/imlib2-1.2.0
	>=media-libs/edje-0.5.0
	>=x11-libs/ecore-0.9.9
	>=x11-libs/evas-0.9.9
	>=x11-libs/ewl-0.0.4
	>=app-misc/examine-0.0.1.20050116"

src_compile() {
	export MY_ECONF="$(use_enable xinerama)"
	enlightenment_src_compile
}

src_install() {
	enlightenment_src_install
	exeinto /usr/share/engage
	doexe build_icon.sh
}
