# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/engage/engage-9999.ebuild,v 1.4 2005/03/18 05:22:55 vapier Exp $

ECVS_MODULE="misc/engage"
EHACKAUTOGEN=yes
inherit enlightenment

DESCRIPTION="nice bar thingy"

IUSE="xinerama"

DEPEND=">=x11-libs/esmart-0.9.0.20041009
	>=media-libs/imlib2-1.1.2
	>=media-libs/edje-0.5.0.20041009
	>=x11-libs/ecore-1.0.0.20041009_pre7
	>=x11-libs/evas-1.0.0.20041009_pre13
	>=x11-libs/ewl-0.0.4.20041009
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
