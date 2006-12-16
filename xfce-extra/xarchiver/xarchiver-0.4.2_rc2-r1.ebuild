# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xarchiver/xarchiver-0.4.2_rc2-r1.ebuild,v 1.2 2006/12/16 08:11:15 welp Exp $

inherit eutils xfce44 versionator

MY_PV="$(replace_version_separator 3 '')"
MY_P="${PN}-${MY_PV}"
S="${WORKDIR}/${MY_P}"

xfce44_beta
xfce44_extra_package

DESCRIPTION="A GTK2 frontend to rar, zip, bzip2, tar, gzip
and rpm for Xfce"
HOMEPAGE="http://xarchiver.xfce.org/"

KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE="arj ace rar 7zip rpm"

DEPEND=">=x11-libs/gtk+-2.6
	app-arch/zip
	app-arch/bzip2"
RDEPEND="${DEPEND}
	arj? ( || ( app-arch/unarj app-arch/arj ) )
	ace? ( app-arch/unace )
	rar? ( || ( app-arch/unrar app-arch/rar ) )
	7zip? ( app-arch/p7zip )
	rpm? ( app-arch/rpm )"
