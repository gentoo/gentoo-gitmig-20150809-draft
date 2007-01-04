# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/partysip/partysip-2.2.3.ebuild,v 1.5 2007/01/04 16:37:51 flameeyes Exp $

IUSE="berkdb debug syslog"

WANT_AUTOMAKE="latest"
WANT_AUTOCONF="latest"

inherit eutils autotools

DESCRIPTION="Modular and extensible SIP proxy"
HOMEPAGE="http://savannah.nongnu.org/projects/partysip/"
SRC_URI="http://savannah.gnu.org/download/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="LGPL-2" # not 100% about -2, but core is LGPL
KEYWORDS="~ppc ~sparc ~x86"

DEPEND="virtual/libc
	>=net-libs/libosip-2.2.1
	berkdb? ( =sys-libs/db-3* )"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-configure.diff

	# fix libresolv check in configure.in (#107885)
	# instead of res_query, we search for the real (internal)
	# function name __res_query, because res_query isn't in the symbol
	# list of libresolv on amd64
	epatch ${FILESDIR}/${P}-libresolv-check.diff

	# remove unused check in auth plugin (#107886)
	# breaks authentication otherwise
	epatch ${FILESDIR}/${P}-fix_auth.diff

	# put partysip	binary into /usr/sbin
	sed -i -e "s:^bin_PROGRAMS:sbin_PROGRAMS:" \
		src/Makefile.am tools/Makefile.am

	AT_M4DIR="scripts" eautoreconf
}

src_compile() {
	local myconf

	# berkdb3 (preferred) / gdbm (no-worky) / no db...
	if use berkdb; then
		myconf="--with-db=susedb3"
#	elif use gdbm; then
#		myconf="--with-db=gdbm"
#	else
#		myconf="--with-db=no"
	fi

	econf \
		--sbindir=/usr/sbin \
		--enable-semaphore \
		--enable-sysv \
		`use_enable debug trace` \
		`use_enable debug debug` \
		`use_enable syslog` \
		${myconf} || die

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	insinto /etc/partysip
	doins conf/partysip.conf

	chmod 750 ${D}etc/partysip
	chmod 640 ${D}etc/partysip/partysip.conf

	newinitd ${FILESDIR}/partysip.rc6 partysip
	newconfd ${FILESDIR}/partysip.confd partysip

	dodoc README ChangeLog COPYING COPYING-2 TODO AUTHORS INSTALL NEWS
}

pkg_postinst() {
	einfo "Please edit /etc/partysip/partysip.conf!"
}
