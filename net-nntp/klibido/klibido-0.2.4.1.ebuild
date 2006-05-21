# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nntp/klibido/klibido-0.2.4.1.ebuild,v 1.3 2006/05/21 10:29:17 pauldv Exp $

inherit kde db-use

DESCRIPTION="KDE Linux Binaries Downloader"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://klibido.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="debug"

RDEPEND=">=sys-libs/db-4.1"
DEPEND="${RDEPEND}
	dev-libs/uulib"

need-kde 3

src_unpack() {
	kde_src_unpack
	dbincldir="$(db_includedir 4.4 4.3 4.2 4.1)" || die "unable to find db"
	einfo "db include dir = ${dbincldir}"
	if [ ! -d ${dbincldir} ]; then
		die "Db include dir does not exist"
	fi
	sed -i -e "s,-I/usr/include/db4,-I${dbincldir}," ${S}/src/Makefile.am
	sed -i -e "s,-I/usr/include/db4,-I${dbincldir}," ${S}/src/Makefile.in
}

src_compile() {
#	dbincldir="$(db_includedir 4.4 4.3 4.2 4.1)" || die "unable to find db"
#		--with-extra-includes="${dbincldir}/"

	myconf="${myconf}
		$(use_enable debug)
	"
	kde_src_compile
}
