# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Authen-Htpasswd/Authen-Htpasswd-0.16.1.ebuild,v 1.1 2008/10/22 09:17:02 tove Exp $

inherit versionator
MY_P=${PN}-$(delete_version_separator 2)
MODULE_AUTHOR=DKAMHOLZ
S=${WORKDIR}/${MY_P}
inherit perl-module

DESCRIPTION="interface to read and modify Apache .htpasswd files"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~x86"
IUSE="test"

DEPEND="dev-lang/perl
	dev-perl/Class-Accessor
	dev-perl/IO-LockedFile
	dev-perl/Crypt-PasswdMD5
	dev-perl/Digest-SHA1"
# pod tests need TEST_POD anyway

SRC_TEST=do
