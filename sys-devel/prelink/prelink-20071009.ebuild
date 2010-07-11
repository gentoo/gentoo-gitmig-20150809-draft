# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/prelink/prelink-20071009.ebuild,v 1.9 2010/07/11 11:17:40 armin76 Exp $

# the tar.bz2 was ripped from this rpm:
# http://mirrors.kernel.org/fedora/development/source/SRPMS/prelink-0.4.0-1.src.rpm

inherit eutils

DESCRIPTION="modifies ELFs so they load faster at runtime"
HOMEPAGE="http://people.redhat.com/jakub/prelink"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	ftp://people.redhat.com/jakub/prelink/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 s390 sparc x86"
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
	epatch "${FILESDIR}"/${PN}-20061201-prelink-conf.patch
	sed -i -e 's:undosyslibs.sh::' testsuite/Makefile.in #254201
	sed -i \
		-e '/^CC=/s: : -Wl,--disable-new-dtags :' \
		testsuite/functions.sh #100147
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

	dodoc INSTALL TODO ChangeLog THANKS README AUTHORS NEWS
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
