# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/opensp/opensp-1.5-r1.ebuild,v 1.24 2004/07/14 14:02:28 agriffis Exp $

inherit eutils gnuconfig

MY_P=${P/opensp/OpenSP}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A free, object-oriented toolkit for SGML parsing and entity management"
HOMEPAGE="http://openjade.sourceforge.net/"
SRC_URI="mirror://sourceforge/openjade/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 s390 ppc64"
IUSE="nls"

DEPEND="nls? ( sys-devel/gettext )"
PDEPEND=">=app-text/openjade-1.3.2"

# Note: openjade is in PDEPEND because starting from openjade-1.3.2, opensp
#       has been SPLIT from openjade into its own package. Hence if you
#       install this, you need to upgrade to a new openjade as well.

src_unpack() {
	unpack ${A}
	cd ${S}
	# from gentoo bug #21631 and
	# http://sourceforge.net/tracker/index.php?func=detail&aid=742214&group_id=2115&atid=302115
	epatch ${FILESDIR}/${P}-gcc33.patch
	epatch ${FILESDIR}/${P}-gcc34.patch
}

src_compile() {
	local myconf

	# Detect mips systems properly
	gnuconfig_update

	myconf="${myconf} --enable-default-catalog=/etc/sgml/catalog"
	myconf="${myconf} --enable-default-search-path=/usr/share/sgml"
	myconf="${myconf} --datadir=/usr/share/sgml/${P}"
	econf ${myconf} $(use_enable nls) || die "econf failed"
	emake pkgdocdir=/usr/share/doc/${PF} || die "parallel make failed"
}

src_install() {
	make DESTDIR=${D} pkgdocdir=/usr/share/doc/${PF} install || die
}
