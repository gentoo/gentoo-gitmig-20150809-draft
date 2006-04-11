# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/sparc-utils/sparc-utils-1.9-r3.ebuild,v 1.2 2006/04/11 23:23:51 vapier Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Various sparc utilities from Debian GNU/Linux"
HOMEPAGE="http://www.debian.org/"
SRC_URI=" http://http.us.debian.org/debian/pool/main/s/${PN}/${PN}_${PV}.orig.tar.gz
	mirror://gentoo/${PN}_${PV}-2.diff.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* sparc"
IUSE=""

DEPEND="virtual/os-headers"
RDEPEND="sys-apps/setarch"

S=${WORKDIR}/${P}.orig

src_unpack() {
	unpack ${A}
	epatch ${WORKDIR}/${PN}_${PV}-2.diff
}

src_compile() {
	emake -C elftoaout-2.3 CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die
	emake -C src piggyback piggyback64 CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die
	emake -C prtconf-1.3 CC="$(tc-getCC)" all || die
	emake -C audioctl-1.3 CC="$(tc-getCC)" || die
}

src_install() {
	# since the debian/piggyback64.1 manpage is a pointer to the
	# debian/piggyback.1 manpage, copy debian/piggyback.1 to
	# debian/piggyback64.1

	cp ${S}/debian/piggyback.1 ${S}/debian/piggyback64.1

	dobin elftoaout-2.3/elftoaout || die
	dobin src/piggyback || die
	dobin src/piggyback64 || die
	dosbin prtconf-1.3/prtconf || die
	dosbin prtconf-1.3/eeprom || die

	dobin audioctl-1.3/audioctl || die

	newinitd "${FILESDIR}"/audioctl.init audioctl || die
	newconfd debian/audioctl.def audioctl || die

	doman audioctl-1.3/audioctl.1
	doman elftoaout-2.3/elftoaout.1
	doman prtconf-1.3/prtconf.8
	doman prtconf-1.3/eeprom.8
	doman debian/piggyback.1
	doman debian/piggyback64.1
}

pkg_postinst() {
	ewarn "In order to /usr/sbin/eeprom, make sure you build /dev/openprom"
	ewarn "device support (CONFIG_SUN_OPENPROMIO) into the kernel, or as a"
	ewarn "module (and that the module is loaded)."
	ewarn ""
	ewarn "If you are not using devfs, you can create /dev/openprom"
	ewarn "with the following command:"
	ewarn "\tcd /dev ; mknod openprom c 10 139"
}
