# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/ksimus/ksimus-0.3.6-r1.ebuild,v 1.5 2003/12/12 08:15:43 phosphan Exp $

inherit kde-base

MY_PATCH="ksimus-patch-0.3.6-2"
DESCRIPTION="KSimus is a KDE tool for simulation, automatization and visualization of technical processes."
HOMEPAGE="http://ksimus.berlios.de/"
KEYWORDS="x86"
SRC_URI="http://ksimus.berlios.de/download/ksimus-3-${PV}.tar.gz
		http://ksimus.berlios.de/download/${MY_PATCH}.gz"

LICENSE="GPL-2"
SLOT="0"

DEPEND=">=sys-apps/sed-4
		sys-devel/autoconf"
RDEPEND=""

need-kde 3
inherit eutils

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ../${MY_PATCH}
	sed -i 's/head -\([1-9]\)/head -n \1/g' acinclude.m4 aclocal.m4 configure \
		admin/acinclude.m4.in admin/cvs.sh admin/libtool.m4.in
	make -f Makefile.dist # configure.in.in was patched
}

