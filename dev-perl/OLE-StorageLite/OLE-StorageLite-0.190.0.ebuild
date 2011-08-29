# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/OLE-StorageLite/OLE-StorageLite-0.190.0.ebuild,v 1.1 2011/08/29 11:16:04 tove Exp $

EAPI=4

MY_PN=OLE-Storage_Lite
MODULE_AUTHOR=JMCNAMARA
MODULE_VERSION=0.19
inherit perl-module

DESCRIPTION="Simple Class for OLE document interface"

SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86 ~ppc-macos ~x64-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE=""

SRC_TEST="do"
