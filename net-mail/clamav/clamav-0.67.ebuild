# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/clamav/clamav-0.67.ebuild,v 1.2 2004/02/17 01:16:11 vapier Exp $

inherit eutils flag-o-matic

DESCRIPTION="Clam Anti-Virus Scanner"
HOMEPAGE="http://www.clamav.net/"
SRC_URI="mirror://sourceforge/clamav/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ppc ~sparc ~mips ~alpha ~arm ~hppa ~amd64"
IUSE="milter"

DEPEND="virtual/glibc"
PROVIDE="virtual/antivirus"

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
	if [ `use milter` ]; then
		einfo "For simple instructions howto setup the clamav-milter..."
		einfo ""
		einfo "less /usr/share/doc/${PVR}/clamav-milter.README.gentoo.gz"
	fi
}
