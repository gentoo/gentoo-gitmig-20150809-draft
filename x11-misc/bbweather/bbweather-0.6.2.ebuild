# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbweather/bbweather-0.6.2.ebuild,v 1.11 2012/03/18 15:21:22 armin76 Exp $

DESCRIPTION="blackbox weather monitor"
HOMEPAGE="http://www.netmeister.org/apps/bbweather/"
SRC_URI="http://www.netmeister.org/apps/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="hppa ppc x86"
IUSE=""

DEPEND=">=net-misc/wget-1.7
	>=dev-lang/perl-5.6.1"
RDEPEND="${DEPEND}
	!<=x11-plugins/gkrellweather-2.0.7-r1"

src_install () {
	make DESTDIR="${D}" install || die "make install failed"
	rm -rf "${D}"/usr/share/doc
	dodoc README AUTHORS INSTALL ChangeLog NEWS TODO data/README.bbweather
	dohtml -r doc

	# since multiple bbtools packages provide this file, install
	# it in /usr/share/doc/${PF}
	mv "${D}"/usr/share/bbtools/bbtoolsrc.in \
		"${D}"/usr/share/doc/${PF}/bbtoolsrc.example

}
