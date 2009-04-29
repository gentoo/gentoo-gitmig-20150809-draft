# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Authen-Htpasswd/Authen-Htpasswd-0.16.1.ebuild,v 1.5 2009/04/29 15:27:03 tove Exp $

EAPI=2

inherit versionator
MY_P=${PN}-$(delete_version_separator 2)
MODULE_AUTHOR=DKAMHOLZ
S=${WORKDIR}/${MY_P}
inherit perl-module

DESCRIPTION="interface to read and modify Apache .htpasswd files"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-perl/Class-Accessor
	dev-perl/IO-LockedFile
	dev-perl/Crypt-PasswdMD5
	dev-perl/Digest-SHA1"
# pod tests need TEST_POD anyway
RDEPEND="${DEPEND}"

SRC_TEST=do
