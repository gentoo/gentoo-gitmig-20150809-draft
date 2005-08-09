# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/ksimus-datarecorder/ksimus-datarecorder-0.3.6.ebuild,v 1.3 2005/08/09 13:36:56 phosphan Exp $

inherit kde eutils fixheadtails

MYPATCH="${PN}-${PV}-namespaces.patch"
HOMEPAGE="http://ksimus.berlios.de/"
DESCRIPTION="The package Data Recorder contains some components which record data for KSimus."
KEYWORDS="x86"
SRC_URI="http://ksimus.berlios.de/download/${PN}-3-${PV}.tar.gz
		mirror://gentoo/${MYPATCH}.bz2"

LICENSE="GPL-2"
IUSE=""
SLOT="0"

DEPEND="sci-mathematics/ksimus"

need-kde 3

src_unpack() {
	unpack ${A}
	unpack ${MYPATCH}.bz2
	cd ${S}
	epatch ${WORKDIR}/${MYPATCH}
	ht_fix_file acinclude.m4 aclocal.m4 configure \
			admin/acinclude.m4.in admin/cvs.sh admin/libtool.m4.in

	sed -e 's/.*MISSING_ARTS_ERROR(.*//' -i admin/acinclude.m4.in || \
			die "could not remove ARTS check"
	make -f Makefile.dist
}
