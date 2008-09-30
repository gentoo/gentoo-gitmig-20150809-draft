# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTTPD-User-Manage/HTTPD-User-Manage-1.66.ebuild,v 1.5 2008/09/30 14:00:45 tove Exp $

MODULE_AUTHOR=LDS
inherit perl-module

DESCRIPTION="Perl module for managing access control of web servers"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ia64 sparc x86"
IUSE=""

DEPEND="dev-lang/perl"

SRC_TEST="do"
