# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/cpu/cpu-1.3.100-r1.ebuild,v 1.3 2003/08/05 14:24:03 vapier Exp $

DESCRIPTION="LDAP user management tool written in C and loosely based on FreeBSD's pw(8)"
HOMEPAGE="http://cpu.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

RDEPEND="net-nds/openldap
	sys-libs/cracklib"
DEPEND="${RDEPEND}
	>=sys-devel/autoconf-2.54"

WANT_AUTOCONF_2_5=1

pkg_setup() {
	if use static; then
		eerror "Sorry, the package does NOT support static building."
	fi
	return 0
}

src_compile() {
	local myconf

	# provide PASSWD support as well
	# It's broken in the application at the moment, so lets not...
	# myconf="${myconf} --with-passwd"

	# Tell it where to find LDAP
	myconf="${myconf} --with-ldap"
	# Tell it where to find CRACKLIB
	myconf="${myconf} --with-libcrack"

	# cache our config!
	#myconf="${myconf} --cache-file=${S}/config.cache"

	# This app really belongs in sbin!
	myconf="${myconf} --bindir=/usr/sbin"

	econf ${myconf} || die "Configure failure"

	emake || die "Make failure"
}

src_install() {
	einstall bindir="${D}/usr/sbin" || die "Einstall failure"
	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}
