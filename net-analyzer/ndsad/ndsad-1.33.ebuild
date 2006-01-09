# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ndsad/ndsad-1.33.ebuild,v 1.1 2006/01/09 10:56:49 pva Exp $

DESCRIPTION="NetUP Data Stream Accounting Daemon"
HOMEPAGE="http://sourceforge.net/projects/ndsad"
SRC_URI="mirror://sourceforge/ndsad/ndsad-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=net-libs/libpcap-0.8"
DEPEND="${RDEPEND}
		=sys-devel/automake-1.7*
		=sys-devel/autoconf-2.5*"

src_unpack() {
	einfo "Regenerating autotools files..."
	export WANT_AUTOCONF=2.5
	export WANT_AUTOMAKE=1.7

	unpack ${A}

	cd ${S}

	# Puttind ndsad binary in sbin.
	sed -i "s/bin_PROGRAMS = ndsad/sbin_PROGRAMS = ndsad/" Makefile.am || \
	die	"Can not change bin->sbin in Makefile.am... sed failed"

	sed -i \
	"s:^#define conf_path \"/netup/utm5/ndsad.cfg\":#define conf_path \"/etc/ndsad.conf\":" \
	ndsad.cc || die "Can not change default config path... sed failed"

	sed -i "s:log /tmp/ndsad.log:log /var/log/ndsad.log:" ndsad.conf || \
	die "Can not fix logging path in ndsad.conf... sed failed"

	./preconf
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

	exeinto /etc/init.d
	newexe ${FILESDIR}/ndsad.init ndsad

	insinto /etc/conf.d
	newins ${FILESDIR}/ndsad.conf.d ndsad

	dodoc ChangeLog AUTHORS README
}
