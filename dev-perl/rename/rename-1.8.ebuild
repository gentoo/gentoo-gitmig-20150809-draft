# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/rename/rename-1.8.ebuild,v 1.1 2010/10/27 14:30:59 ssuominen Exp $

EAPI=3

MODULE_AUTHOR=PEDERST

inherit perl-module

DESCRIPTION="A filename renaming utility based on perl regular expression"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_install() {
	perl-module_src_install

	mv -vf "${D}"/usr/bin/rename "${D}"/usr/bin/perl-rename
	mv -vf "${D}"/usr/share/man/man1/rename.1 "${D}"/usr/share/man/man1/perl-rename.1
}
