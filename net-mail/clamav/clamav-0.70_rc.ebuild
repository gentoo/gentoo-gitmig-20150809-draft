# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/clamav/clamav-0.70_rc.ebuild,v 1.2 2004/03/30 08:45:25 lordvan Exp $

inherit eutils flag-o-matic

MY_P="${PN}-0.70-rc"
DESCRIPTION="Clam Anti-Virus Scanner"
HOMEPAGE="http://www.clamav.net/"
SRC_URI="mirror://sourceforge/clamav/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~hppa ~amd64 ~ia64"
IUSE="milter crypt"

DEPEND="virtual/glibc
	crypt? ( >=dev-libs/gmp-4.1.2 )"
PROVIDE="virtual/antivirus"
S="${WORKDIR}/${MY_P}"

pkg_setup() {
	enewgroup clamav
	enewuser clamav -1 /bin/false /dev/null clamav
	pwconv || die
}

src_compile() {
	has_version =sys-libs/glibc-2.2* && filter-flags -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE

	local myconf
	use milter && myconf="--enable-milter"
	econf ${myconf} --with-dbdir=/var/lib/clamav || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS NEWS README ChangeLog TODO FAQ INSTALL
	exeinto /etc/init.d ; newexe ${FILESDIR}/clamd.rc clamd
	insinto /etc/conf.d ; newins ${FILESDIR}/clamd.conf clamd
	dodoc ${FILESDIR}/clamav-milter.README.gentoo
}

pkg_postinst() {
	if use milter ; then
		einfo "For simple instructions howto setup the clamav-milter..."
		einfo ""
		einfo "less /usr/share/doc/${PF}/clamav-milter.README.gentoo.gz"
	fi
}
