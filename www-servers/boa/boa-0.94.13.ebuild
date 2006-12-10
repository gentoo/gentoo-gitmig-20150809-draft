# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/boa/boa-0.94.13.ebuild,v 1.2 2006/12/10 09:06:58 beu Exp $

inherit eutils

DESCRIPTION="Boa - A very small and very fast http daemon"
SRC_URI="http://www.boa.org/${P}.tar.gz"
HOMEPAGE="http://www.boa.org/"

KEYWORDS="x86 sparc ~mips"
LICENSE="GPL-2"
SLOT="0"
IUSE="tetex"

DEPEND="sys-devel/flex
	sys-devel/bison
	tetex? ( virtual/tetex )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gcc3.patch || die
}

src_compile() {
	cd src
	econf || die "econf failed"
	emake || die
	cd ../docs
	make boa.html boa.info || die
	use tetex && make boa.dvi
}

src_install() {
	# make prefix=${D}/usr install
	dosbin src/boa || die
	doman docs/boa.8 || die
	dodoc docs/boa.html || die
	dodoc docs/boa_banner.png || die
	doinfo docs/boa.info || die
	if use tetex; then
		dodoc docs/boa.dvi || die
	fi

	dodir /var/log/boa || die
	dodir /home/httpd/htdocs || die
	dodir /home/httpd/cgi-bin || die
	dodir /home/httpd/icons || die

	exeinto /usr/lib/boa
	doexe src/boa_indexer || die

	exeinto /etc/init.d
	newexe ${FILESDIR}/boa.rc6 boa || die

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
