# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/gonvert/gonvert-0.2.12.ebuild,v 1.1 2005/12/24 14:58:00 chainsaw Exp $

inherit eutils

DESCRIPTION="Unit conversion utility written in PyGTK"
HOMEPAGE="http://unihedron.com/projects/gonvert/gonvert.php"
SRC_URI="http://unihedron.com/projects/gonvert/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="=dev-python/pygtk-2*"

pkg_setup() {
	# see Gentoo Bugzilla bug 2272
	built_with_use "=dev-python/pygtk-2*" gnome ||
	{ eerror "PyGTK must be compiled with libglade support for gonvert to run."
	  eerror "Please reemerge pygtk with the \"gnome\" USE flag."
	  die "No libglade support in pygtk."
	}
}

src_unpack () {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-about.patch || die
}

src_install () {
	make install DESTDIR="${D}" prefix=/usr || die
	rm -fr "${D}/usr/share/doc/${PN}"
	dodoc doc/CHANGELOG doc/FAQ doc/README doc/THANKS doc/TODO
}
