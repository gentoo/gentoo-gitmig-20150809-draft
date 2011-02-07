# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Wx-Perl-ProcessStream/Wx-Perl-ProcessStream-0.300.ebuild,v 1.1 2011/02/07 18:48:59 robbat2 Exp $

EAPI=3

WX_GTK_VER="2.8"
MODULE_AUTHOR=MDOOTSON
MODULE_VERSION=0.30
inherit wxwidgets perl-module

DESCRIPTION="access IO of external processes via events"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	x11-libs/wxGTK:2.8
	>=dev-perl/wxperl-0.97.01"
DEPEND="${RDEPEND}"

#SRC_TEST=do
