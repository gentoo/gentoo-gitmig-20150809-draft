# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/prelink/prelink-20100714.ebuild,v 1.1 2010/07/21 05:26:21 dirtyepic Exp $

EAPI="2"

inherit eutils

DESCRIPTION="Modifies ELFs to avoid runtime symbol resolutions resulting in faster load times"
HOMEPAGE="http://people.redhat.com/jakub/prelink"
#SRC_URI="http://people.redhat.com/jakub/prelink/${P}.tar.bz2"
# if not on http://people.redhat.com/jakub/prelink/, releases can usually be ripped from
# http://mirrors.kernel.org/fedora/development/source/SRPMS/prelink-<blah>.src.rpm
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 -arm ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE=""

DEPEND=">=dev-libs/elfutils-0.100
	!dev-libs/libelf
	>=sys-libs/glibc-2.8"
RDEPEND="${DEPEND}
	>=sys-devel/binutils-2.18"

S=${WORKDIR}/${PN}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-20061201-prelink-conf.patch

	sed -i -e 's:undosyslibs.sh::' testsuite/Makefile.in #254201
	sed -i -e '/^CC=/s: : -Wl,--disable-new-dtags :' testsuite/functions.sh #100147
}

src_test() {
	unset LD_AS_NEEDED # 303797
	emake -j1 check
}

src_install() {
	emake DESTDIR="${D}" install || die "Install Failed"

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

	dodoc TODO ChangeLog
}

pkg_postinst() {
	echo
	elog "You may wish to read the Gentoo Linux Prelink Guide, which can be"
	elog "found online at:"
	elog
	elog "    http://www.gentoo.org/doc/en/prelink-howto.xml"
	elog
	elog "Please edit /etc/conf.d/prelink to enable and configure prelink"
	echo
	touch "${ROOT}/var/lib/misc/prelink.force"
}
