# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Goo-Canvas/Goo-Canvas-0.06.ebuild,v 1.1 2009/08/05 12:19:54 hwoarang Exp $

EAPI=2

MODULE_AUTHOR=YEWENBIN
inherit perl-module

DESCRIPTION="Perl interface to the GooCanvas"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="x11-libs/goocanvas"
RDEPEND="${DEPEND}"

PATCHES=(
	# this patch fixes segfaults on amd64 platforms
	"${FILESDIR}"/fix_implicit_pointer_declaration.patch
)
