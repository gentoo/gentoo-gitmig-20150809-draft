# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ndsad/ndsad-1.33.ebuild,v 1.6 2007/04/22 06:27:30 pva Exp $

WANT_AUTOCONF=2.5
WANT_AUTOMAKE=1.9
inherit autotools

DESCRIPTION="Cisco netflow probe from libpcap, ULOG, tee/divert sources."
HOMEPAGE="http://sourceforge.net/projects/ndsad"
SRC_URI="mirror://sourceforge/ndsad/ndsad-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=net-libs/libpcap-0.8"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Put ndsad binary in sbin.
	sed -i "s/bin_PROGRAMS = ndsad/sbin_PROGRAMS = ndsad/" Makefile.am || \
	die	"Can not change bin->sbin in Makefile.am... sed failed"

	sed -i \
	"s:^#define conf_path \"/netup/utm5/ndsad.cfg\":#define conf_path \"/etc/ndsad.conf\":" \
	ndsad.cc || die "Can not change default config path... sed failed"

	sed -i "s:log /tmp/ndsad.log:log /var/log/ndsad.log:" ndsad.conf || \
	die "Can not fix logging path in ndsad.conf... sed failed"

	aclocal
	eautomake
	eautoconf
}

src_compile() {
	econf --with-ulog=yes || die "configure failed"
	emake || die "compilation failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"

	doman ndsad.conf.5

	insinto /etc
	newins ndsad.conf ndsad.conf

	newinitd "${FILESDIR}"/ndsad.init ndsad
	newconfd "${FILESDIR}"/ndsad.conf.d ndsad

	dodoc ChangeLog AUTHORS README
}
