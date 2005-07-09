# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/ksimus/ksimus-0.3.6-r1.ebuild,v 1.4 2005/07/09 23:31:43 weeve Exp $

inherit kde eutils

MY_PATCH="ksimus-patch-0.3.6-2"
DESCRIPTION="KSimus is a KDE tool for simulation, automatization and visualization of technical processes."
HOMEPAGE="http://ksimus.berlios.de/"
SRC_URI="http://ksimus.berlios.de/download/ksimus-3-${PV}.tar.gz
	http://ksimus.berlios.de/download/${MY_PATCH}.gz
	mirror://gentoo/${P}-gcc3.4.patch.bz2
	http://dev.gentoo.org/~phosphan/${P}-gcc3.4.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~sparc x86"
IUSE=""

DEPEND=">=sys-apps/sed-4
	sys-devel/autoconf"
RDEPEND=""
need-kde 3

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ../${MY_PATCH}
	epatch ../${P}-gcc3.4.patch
	sed -i 's/head -\([1-9]\)/head -n \1/g' acinclude.m4 aclocal.m4 configure \
		admin/acinclude.m4.in admin/cvs.sh admin/libtool.m4.in
	# does not really need arts
	sed -e 's/.*MISSING_ARTS_ERROR(.*//' -i admin/acinclude.m4.in
	make -f Makefile.dist # configure.in.in was patched
}
