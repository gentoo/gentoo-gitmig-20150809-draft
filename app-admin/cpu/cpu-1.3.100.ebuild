# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/cpu/cpu-1.3.100.ebuild,v 1.2 2003/07/05 08:57:48 robbat2 Exp $

DESCRIPTION="CPU is an LDAP user management tool written in C and loosely based on FreeBSD's pw(8)."
HOMEPAGE="http://cpu.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RDEPEND="net-nds/openldap
		sys-libs/cracklib"

DEPEND="${RDEPEND}
		>=sys-devel/autoconf-2.54"

S=${WORKDIR}/${P}

WANT_AUTOCONF_2_5=1

src_compile() {

	if use static; then
		MSG="Sorry, the package does NOT support static building."
		eerror "${MSG}"
	fi

	# The package has a history of bad configure files...
	epatch ${FILESDIR}/${P}-fixup.patch
	autoconf
	
	local myconf

	# provide PASSWD support as well
	# It's broken in the application at the moment, so lets not...
	# myconf="${myconf} --with-passwd"

	# Tell it where to find LDAP
	myconf="${myconf} --with-ldap=/usr"
	# Tell it where to find CRACKLIB
	myconf="${myconf} --with-libcrack=/usr"

	# cache our config!
	myconf="${myconf} --cache-file=${S}/config.cache"
	
	econf ${myconf} || die "Configure failure"

	emake || die "Make failure"
}

src_install() {
	einstall || die "Einstall failure"
	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}
