# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/boa/boa-0.94.14_alpha20.ebuild,v 1.3 2007/04/24 13:29:49 bangert Exp $

inherit eutils

DESCRIPTION="Boa - A very small and very fast http daemon"
SRC_URI="http://www.boa.org/${PN}-${PV/_alpha/rc}.tar.gz"
HOMEPAGE="http://www.boa.org/"

KEYWORDS="~x86 ~sparc ~mips ppc"
LICENSE="GPL-2"
SLOT="0"
IUSE="tetex"
S=${WORKDIR}/${PN}-${PV/_alpha/rc}
DEPEND="sys-devel/flex
	sys-devel/bison
	tetex? ( virtual/tetex )"

src_unpack() {
	unpack ${A}
	cd ${S} || die hrmm
}

src_compile() {
	econf || die "econf failed"
	emake || die
	cd docs
	if hasq noinfo $FEATURES $RESTRICT; then
		make boa.html
	else
		make boa.html boa.info || die
	fi
	# SLH - 2004/04/23
	# commented out - this doesn't appear to work, and I'm not tetex
	# expert, so I don't know how to fix it
	#
	# use tetex && make boa.dvi
}

src_install() {
	# make prefix=${D}/usr install
	dosbin src/boa || die
	doman docs/boa.8 || die
	dodoc docs/boa.html || die
	dodoc docs/boa_banner.png || die
	hasq noinfo $FEATURES $RESTRICT || doinfo docs/boa.info
#	if use tetex; then
#		dodoc docs/boa.dvi || die
#	fi

	dodir /var/log/boa || die
	dodir /var/www/localhost/htdocs || die
	dodir /var/www/localhost/cgi-bin || die
	dodir /var/www/localhost/icons || die

	newconfd ${FILESDIR}/boa.conf.d boa
	newinitd ${FILESDIR}/boa.rc6 boa || die

	exeinto /usr/lib/boa
	doexe src/boa_indexer || die

	insinto /etc/boa
	insopts -m700
	insopts -m600
	doins ${FILESDIR}/boa.conf || die
	doins ${FILESDIR}/mime.types || die

	# make DESTDIR=${D} install || die
}

pkg_prerm() {
	if [ "$ROOT" = "/" ] && [ -e /dev/shm/.init.d/started/boa ] ; then
		/etc/init.d/boa stop
	fi
	return # dont fail
}

pkg_preinst() {
	if [ "$ROOT" = "/" ] && [ -e /dev/shm/.init.d/started/boa ] ; then
		/etc/init.d/boa stop
	fi
	return # dont fail
}
