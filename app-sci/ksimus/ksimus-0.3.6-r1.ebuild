# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/ksimus/ksimus-0.3.6-r1.ebuild,v 1.9 2004/06/29 11:51:44 carlo Exp $

inherit kde eutils

MY_PATCH="ksimus-patch-0.3.6-2"
DESCRIPTION="KSimus is a KDE tool for simulation, automatization and visualization of technical processes."
HOMEPAGE="http://ksimus.berlios.de/"
SRC_URI="http://ksimus.berlios.de/download/ksimus-3-${PV}.tar.gz
	http://ksimus.berlios.de/download/${MY_PATCH}.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=sys-apps/sed-4
	sys-devel/autoconf"
RDEPEND=""
need-kde 3

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ../${MY_PATCH}
	sed -i 's/head -\([1-9]\)/head -n \1/g' acinclude.m4 aclocal.m4 configure \
		admin/acinclude.m4.in admin/cvs.sh admin/libtool.m4.in
	make -f Makefile.dist # configure.in.in was patched
}
