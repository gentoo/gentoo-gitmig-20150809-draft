# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/procps/procps-3.2.4.ebuild,v 1.4 2004/11/15 18:56:05 vapier Exp $

inherit flag-o-matic eutils

DESCRIPTION="Standard informational utilities and process-handling tools"
HOMEPAGE="http://procps.sourceforge.net/"
SRC_URI="http://${PN}.sf.net/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

RDEPEND=">=sys-libs/ncurses-5.2-r2"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Clean up the makefile
	# firstly we want to control stripping
	# and secondly these gcc flags have changed
	sed -i Makefile \
	-e '/install/s: --strip : :' \
	-e '/ALL_CFLAGS += $(call check_gcc,-fweb,)/d' \
	-e '/ALL_CFLAGS += $(call check_gcc,-Wstrict-aliasing=2,)/s,=2,,'
	use ppc && \
	sed -i Makefile -e 's:-m64::g'

	# mips 2.4.23 headers (and 2.6.x) don't allow PAGE_SIZE to be defined in
	# userspace anymore, so this patch instructs procps to get the
	# value from sysconf().
	use mips && epatch ${FILESDIR}/${PN}-mips-define-pagesize.patch

}

src_compile() {
	replace-flags -O3 -O2
	unset NAME
	emake -e || die
}

src_install() {
	einstall -e DESTDIR="${D}"|| die

	insinto /usr/include/proc
	doins proc/*.h

	dodoc sysctl.conf BUGS NEWS TODO ps/HACKING
}

pkg_postinst() {
	einfo "NOTE: With NPTL \"ps\" and \"top\" no longer"
	einfo "show threads. You can use any of: -m m -L -T H"
	einfo "in ps or the H key in top to show them"
}
