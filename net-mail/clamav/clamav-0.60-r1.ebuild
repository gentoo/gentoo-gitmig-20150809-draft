# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/clamav/clamav-0.60-r1.ebuild,v 1.3 2003/11/26 11:14:57 aliz Exp $

IUSE="milter"

inherit eutils flag-o-matic
has_version =sys-libs/glibc-2.2* && filter-flags -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE

DESCRIPTION="Clam Anti-Virus Scanner"
HOMEPAGE="http://clamav.elektrapro.com"
SRC_URI="http://prdownloads.sourceforge.net/clamav/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~arm ~hppa ~amd64"

DEPEND="virtual/glibc"
PROVIDE="virtual/antivirus"

pkg_setup() {
	enewgroup clamav
	enewuser clamav -1 /bin/false /dev/null clamav
	pwconv || die
}

src_compile() {
	local myconf

	use milter && myconf="--enable-milter"

	econf ${myconf} || die

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
