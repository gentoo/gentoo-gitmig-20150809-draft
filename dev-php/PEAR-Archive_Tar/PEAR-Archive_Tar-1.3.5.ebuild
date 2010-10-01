# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Archive_Tar/PEAR-Archive_Tar-1.3.5.ebuild,v 1.6 2010/10/01 01:01:23 ranger Exp $

MY_PN="${PN/PEAR-/}"
MY_P="${MY_PN}-${PV}"

inherit depend.php

DESCRIPTION="Tar file management class"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm ~hppa ia64 ppc ppc64 s390 sh sparc x86"
IUSE=""
SRC_URI="http://pear.php.net/get/${MY_P}.tgz"
DEPEND=">=dev-php/PEAR-PEAR-1.8.1"
PDEPEND="dev-php/pear"
HOMEPAGE="http://pear.php.net/package/Archive_Tar"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	require_php_with_use pcre
}

src_install() {
	insinto /usr/share/php/Archive
	doins Archive/*

	dodoc docs/*
}
