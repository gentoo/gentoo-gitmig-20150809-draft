# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/autoconf/autoconf-2.59-r6.ebuild,v 1.1 2004/10/21 01:06:27 vapier Exp $

inherit eutils

DESCRIPTION="Used to create autoconfiguration files"
HOMEPAGE="http://www.gnu.org/software/autoconf/autoconf.html"
SRC_URI="mirror://gnu/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="${PV:0:3}"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE=""

DEPEND=">=sys-apps/texinfo-4.3
	sys-devel/autoconf-wrapper
	=sys-devel/m4-1.4*
	dev-lang/perl"

src_compile() {
	econf --program-suffix="-${PV}" || die
	# We want to transform the binaries, not the manpages
	sed -i "/^program_transform_name/s:-${PV}::" man/Makefile
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die

	dodoc AUTHORS BUGS NEWS README TODO THANKS \
		ChangeLog ChangeLog.0 ChangeLog.1 ChangeLog.2

	# binutils installs this infopage
	rm -f "${D}"/usr/share/info/standards.*
}

pkg_postinst() {
	einfo "Please note that the 'WANT_AUTOCONF_2_5=1' syntax is now:" 
	einfo "  WANT_AUTOCONF=2.5"
}
