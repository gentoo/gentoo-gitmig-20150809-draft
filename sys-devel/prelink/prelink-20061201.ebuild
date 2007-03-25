# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/prelink/prelink-20061201.ebuild,v 1.2 2007/03/25 06:40:08 vapier Exp $

# the tar.bz2 was ripped from prelink-0.3.10-1.src.rpm on Fedora mirrors

inherit eutils

DESCRIPTION="modifies ELFs so they load faster at runtime"
HOMEPAGE="http://people.redhat.com/jakub/prelink"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	ftp://people.redhat.com/jakub/prelink/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE=""

DEPEND=">=dev-libs/elfutils-0.100
	!dev-libs/libelf
	>=sys-libs/glibc-2.3.4"
RDEPEND="${DEPEND}
	>=sys-devel/binutils-2.15.90.0.1"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-prelink-conf.patch
	sed -i \
		-e 's:\<deps[12]\.sh\>::g' \
		-e 's:\<undosyslibs.sh\>::' \
		testsuite/Makefile.in #100147
}

src_install() {
	emake install DESTDIR="${D}" || die "Install Failed"

	insinto /etc
	doins doc/prelink.conf || die

	exeinto /etc/cron.daily
	newexe "${FILESDIR}"/prelink.cron prelink
	newconfd "${FILESDIR}"/prelink.confd prelink

	dodir /var/{lib/misc,log}
	touch "${D}/var/lib/misc/prelink.full"
	touch "${D}/var/lib/misc/prelink.quick"
	touch "${D}/var/lib/misc/prelink.force"
	touch "${D}/var/log/prelink.log"

	dodoc INSTALL TODO ChangeLog THANKS COPYING README AUTHORS NEWS
}

pkg_postinst() {
	echo
	elog "You may wish to read the Gentoo Linux Prelink Guide, which can be"
	elog "found online at:"
	elog "    http://www.gentoo.org/doc/en/prelink-howto.xml"
	elog "Added cron job at /etc/cron.daily/prelink"
	elog "Edit /etc/conf.d/prelink to enable / configure"
	echo
	touch "${ROOT}/var/lib/misc/prelink.force"
}
