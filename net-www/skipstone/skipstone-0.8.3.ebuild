# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-www/skipstone/skipstone-0.8.3.ebuild,v 1.3 2002/07/14 20:25:23 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GTK+ based web browser based on the Mozilla engine"
SRC_URI="http://www.muhri.net/skipstone/${P}.tar.gz"
HOMEPAGE="http://www.muhri.net/skipstone/"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=net-www/mozilla-0.9.9
	=x11-libs/gtk+-1.2*"

RDEPEND="${DEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {

	unpack ${A}
	use nls && ( \
		cd ${S}/src
		xgettext -k_ -kN_  ../src/*.[ch]  -o ../locale/skipstone.pot

		# Now we apply a patch to rid the files of duplicate translations
		cd ${WORKDIR}
		patch -p0 < ${FILESDIR}/${PN}-gentoo.patch
	)
}

src_compile() {

	local myconf
	use nls \
		&& myconf="${myconf} --enable-nls"

	econf ${myconf} || die
	
	emake \
		PREFIX="/usr/lib/mozilla" || die
}

src_install () {

	einstall \
		PREFIX=${D}/usr \
		LOCALEDIR=${D}/usr/share/locale \
	|| die
	dodoc AUTHORS COPYING README README.copying 
}
