# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/skipstone/skipstone-0.8.4.ebuild,v 1.1 2003/03/26 07:58:21 seemant Exp $

inherit eutils

IUSE="nls"

DESCRIPTION="GTK+ based web browser based on the Mozilla engine"
SRC_URI="http://www.muhri.net/skipstone/${P}.tar.gz"
HOMEPAGE="http://www.muhri.net/skipstone/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips ~hppa ~arm"

DEPEND="<net-www/mozilla-1.3*
	=x11-libs/gtk+-1.2*"

RDEPEND="${DEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	
	if [ use nls ]
	then
		cd ${S}/src
		xgettext -k_ -kN_  ../src/*.[ch]  -o ../locale/skipstone.pot

		# Now we apply a patch to rid the files of duplicate translations
		cd ${WORKDIR}
		epatch ${FILESDIR}/${PN}-gentoo.patch
	fi
	# patch to compile against newer mozilla, thanks to the debian project
	# (found by nicholas wourms <dragon@gentoo.org>)
#	epatch ${WORKDIR}/${P}-gentoo.diff
	
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
