# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Damon Conway <damon@3jane.net> 
# $Header: /var/cvsroot/gentoo-x86/net-www/skipstone/skipstone-0.8.1-r2.ebuild,v 1.1 2002/04/18 14:14:09 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GTK+ based web browser based on the Mozilla engine"
SRC_URI="http://www.muhri.net/skipstone/${P}.tar.gz"
HOMEPAGE="http://www.muhri.net/skipstone/"

DEPEND=">=net-www/mozilla-0.9.9
	>=x11-libs/gtk+-1.2.10"

RDEPEND="${DEPEND}
	nls? ( sys-devel/gettext )"

use nls && myconf="enable_nls=1"

src_unpack() {

	unpack ${A}
	use nls && ( \
		cd ${S}/src
		xgettext -k_ -kN_  ../src/*.[ch]  -o ../locale/skipstone.pot

		# Now we apply a patch to rid the files of duplicate translations
		cd ${WORKDIR}
		patch -p0 < ${FILESDIR}/skipstone-gentoo.patch
	)
}

src_compile() {

	local myconf
	
    emake \
		${myconf} \
		PREFIX="/usr/lib/mozilla" || die
}

src_install () {

    make \
		PREFIX=${D}/usr \
		LOCALEDIR=${D}/usr/share/locale \
		${myconf} install || die
    dodoc AUTHORS COPYING README README.copying 
}
