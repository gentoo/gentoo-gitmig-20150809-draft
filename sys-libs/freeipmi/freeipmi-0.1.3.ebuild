# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/freeipmi/freeipmi-0.1.3.ebuild,v 1.6 2005/07/09 20:27:32 agriffis Exp $

inherit flag-o-matic

DESCRIPTION="FreeIPMI provides Remote-Console and System Management Software as per IPMI v1.5/2.0"
HOMEPAGE="http://www.gnu.org/software/freeipmi/"
SRC_URI="ftp://ftp.californiadigital.com/pub/freeipmi/download/${PV}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"
RDEPEND="virtual/libc
		dev-util/guile"
DEPEND="${RDEPEND}
		virtual/os-headers
		sys-apps/sed
		doc? ( virtual/tetex )"

src_unpack() {
	unpack ${A}
	sed 's,auth_type_t,output_type_t,' -i.orig \
		"${S}/ipmipower/src/ipmipower_output.c"
}

src_compile() {
	# this is to make things compile
	append-flags "-DHAVE_VPRINTF=1"

	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake -j1 DESTDIR="${D}" docdir="/usr/share/doc/${PF}" install || die "emake install failed"
	dodoc AUTHORS COPYING* ChangeLog DISCLAIMER* NEWS README TODO doc/BUGS
	# this is a redhat-style init script
	# I still need to write a Gentoo init script later on
	rm -f ${D}/etc/init.d/bmc-watchdog
	newdoc ${S}/bmc-watchdog/bmc-watchdog redhat_init-bmc-watchdog
}
