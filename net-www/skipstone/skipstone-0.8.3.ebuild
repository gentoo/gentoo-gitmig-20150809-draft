# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/skipstone/skipstone-0.8.3.ebuild,v 1.10 2002/12/09 04:33:20 manson Exp $

DESCRIPTION="GTK+ based web browser based on the Mozilla engine"
SRC_URI="http://www.muhri.net/skipstone/${P}.tar.gz"
HOMEPAGE="http://www.muhri.net/skipstone/"

KEYWORDS="x86 ppc sparc "
SLOT="0"
LICENSE="GPL-2"
IUSE="nls"

DEPEND="net-www/mozilla
	=x11-libs/gtk+-1.2*"
RDEPEND="${DEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	if [ `use nls` ] ; then
		cd ${S}/src
		xgettext -k_ -kN_  ../src/*.[ch]  -o ../locale/skipstone.pot

		# Now we apply a patch to rid the files of duplicate translations
		cd ${WORKDIR}
		patch -p0 < ${FILESDIR}/${PN}-gentoo.patch
	fi
}

src_compile() {
	local myconf
	use nls && myconf="${myconf} --enable-nls"

	econf ${myconf}
	make PREFIX="/usr/lib/mozilla" || die
}

src_install() {
	einstall \
		PREFIX=${D}/usr \
		LOCALEDIR=${D}/usr/share/locale
	dodoc AUTHORS COPYING README README.copying 
}
