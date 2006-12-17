# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/cpu/cpu-1.4.3-r1.ebuild,v 1.2 2006/12/17 03:48:50 dirtyepic Exp $

inherit eutils

DESCRIPTION="LDAP user management tool written in C and loosely based on FreeBSD's pw(8)"
HOMEPAGE="http://cpu.sourceforge.net/"
SRC_URI="mirror://sourceforge/cpu/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

RDEPEND="net-nds/openldap
	sys-libs/cracklib"
DEPEND="${RDEPEND}
	>=sys-devel/autoconf-2.54"

src_compile() {

	epatch "${FILESDIR}"/${P}-gcc4.patch	# Bug #148731

	export WANT_AUTOCONF=2.5
	sed -i.orig -e 's,$(sysconfdir),$(DESTDIR)$(sysconfdir),g' ${S}/doc/Makefile.in ${S}/doc/Makefile.am

	local myconf

	# provide PASSWD support as well
	# It's broken in the application at the moment, so lets not...
	# myconf="${myconf} --with-passwd"

	# Tell it where to find LDAP
	myconf="${myconf} --with-ldap"
	# Tell it where to find CRACKLIB
	myconf="${myconf} --with-libcrack"

	econf ${myconf} || die "Configure failure"
	emake || die "Make failure"
}

src_install() {
	emake install DESTDIR="${D}" datadir="/usr/share/doc/${PF}" || die "install failure"
	dodoc AUTHORS ChangeLog NEWS README TODO
}
