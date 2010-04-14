# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-SSH-AuthorizedKeysFile/Net-SSH-AuthorizedKeysFile-0.12.ebuild,v 1.1 2010/04/14 15:08:19 idl0r Exp $

EAPI="2"

MODULE_AUTHOR="MSCHILLI"

inherit perl-module

DESCRIPTION="Read and modify ssh's authorized_keys files"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-perl/Log-Log4perl
	dev-lang/perl"

SRC_TEST="do"
