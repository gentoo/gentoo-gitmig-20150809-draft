# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Tk-CursorControl/Tk-CursorControl-0.4.ebuild,v 1.11 2009/06/01 18:26:04 tove Exp $

MODULE_AUTHOR=DUNNIGANJ
inherit eutils perl-module

DESCRIPTION="Manipulate the mouse cursor programmatically"

SLOT="0"
KEYWORDS="amd64 ia64 sparc x86"
IUSE=""

#SRC_TEST="do"

RDEPEND="dev-perl/perl-tk
	dev-lang/perl"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}/${PV}-demo.patch" )

src_prepare() {
	perl-module_src_prepare
	edos2unix "{S}"/{CursorControl.pm,demos/cursor.pl} || die
}
