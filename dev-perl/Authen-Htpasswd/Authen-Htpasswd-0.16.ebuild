# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Authen-Htpasswd/Authen-Htpasswd-0.16.ebuild,v 1.1 2008/09/07 13:33:47 tove Exp $

MODULE_AUTHOR=DKAMHOLZ
inherit perl-module

DESCRIPTION="interface to read and modify Apache .htpasswd files"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-lang/perl
	dev-perl/Class-Accessor
	dev-perl/IO-LockedFile
	dev-perl/Crypt-PasswdMD5
	dev-perl/Digest-SHA1"

SRC_TEST=do
