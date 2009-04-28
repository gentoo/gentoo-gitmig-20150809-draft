# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IPC-Shareable/IPC-Shareable-0.60.ebuild,v 1.4 2009/04/28 09:08:43 tove Exp $

EAPI=2

MODULE_AUTHOR=BSUGARS
inherit perl-module

DESCRIPTION="Tie a variable to shared memory"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

PATCHES=( "${FILESDIR}"/fix_perl_5.10_compat.patch )
SRC_TEST=do
