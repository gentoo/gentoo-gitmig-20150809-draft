# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/keepalived/keepalived-1.1.3.ebuild,v 1.3 2004/01/26 06:41:21 iggy Exp $

DESCRIPTION="The main goal of the keepalived project is to add a strong & robust keepalive facility to the Linux Virtual Server project."
HOMEPAGE="http://keepalived.sourceforge.net"
LICENSE="GPL-2"

DEPEND="dev-libs/popt
	sys-apps/iproute"

SRC_URI="http://keepalived.sourceforge.net/software/${P}.tar.gz"

IUSE=""
SLOT="0"
KEYWORDS="x86 ~sparc ~amd64 ~ppc"
S="${WORKDIR}/${P}"

src_compile() {
	local myconf

	myconf="--prefix=/"

	use debug && myconf="${myconf} --enable-debug"
#	use profile && myconf="${myconf} --enable-profile"

	cd "${S}"
	./configure ${myconf} || die "configure failed"
	emake || die "make failed (myconf=${myconf})"

}

src_install() {

	cd "${S}"
	einstall || die

	exeinto /etc/init.d
	newexe ${FILESDIR}/init-keepalived keepalived

	dodoc doc/* doc/samples/*


}

pkg_postinst() {

	einfo ""
	einfo "If you want Linux Virtual Server support in"
	einfo "keepalived then you must emerge an LVS patched"
	einfo "kernel like gentoo-sources, compile with ipvs"
	einfo "support either as a module or built into the"
	einfo "kernel, emerge the ipvsadm userland tools,"
	einfo "and reemerge keepalived."
	einfo ""
	einfo "For debug support add USE=\"debug\""
	einfo "to your /etc/make.conf"
	einfo ""

}
