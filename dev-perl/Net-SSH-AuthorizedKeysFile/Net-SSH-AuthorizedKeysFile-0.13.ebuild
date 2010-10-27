# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-SSH-AuthorizedKeysFile/Net-SSH-AuthorizedKeysFile-0.13.ebuild,v 1.2 2010/10/27 14:40:54 hwoarang Exp $

EAPI="3"

MODULE_AUTHOR="MSCHILLI"
inherit perl-module

DESCRIPTION="Read and modify ssh's authorized_keys files"

SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/Log-Log4perl"
DEPEND="${RDEPEND}"

SRC_TEST="do"
