# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/foomatic-db/foomatic-db-20060601.ebuild,v 1.1 2006/06/01 22:08:36 genstef Exp $

DESCRIPTION="Foomatic printer database"
HOMEPAGE="http://www.linuxprinting.org/foomatic.html"
SRC_URI="http://gentooexperimental.org/~genstef/dist/${PN}-3.0-${PV}.tar.gz
	ppds? ( http://gentooexperimental.org/~genstef/dist/foomatic-filters-ppds-${PV}.tar.gz )"
# http://linuxprinting.org/download/foomatic

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="ppds"

RDEPEND="net-print/foomatic-filters
	net-print/foomatic-db-engine"

src_compile() {
	econf || die "econf failed"

	if use ppds ; then
		cd ../foomatic-filters-ppds-${PV}
		rm -f $(find . -name "*gimp-print*")
		rm -f $(find . -name "*hpijs*")
		# conflicts with foomatic-filters
		rm -f bin/{foomatic-gswrapper,foomatic-rip}
		rm -f share/man/man1/{foomatic-gswrapper,foomatic-rip}.1
	fi
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	chmod -R go-w,a-x,a+X ${D}/usr/share/foomatic/db/

	if use ppds ; then
		cd ../foomatic-filters-ppds-${PV}
		./install -d ${D} -p /usr -z || die "ppds install failed"
	fi
	# we do not want multiple ppds
	rm -r ${D}/usr/share/foomatic/db/source/PPD/Kyocera/{de,es,fr,it,pt}
}
