# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/ndu/ndu-0.4-r2.ebuild,v 1.1 2005/02/13 03:38:27 robbat2 Exp $

inherit eutils toolchain-funcs

DESCRIPTION="DNS serial number incrementer and reverse zone builder"
URI_BASE="http://uranus.it.swin.edu.au/~jn/linux/"
SRC_URI="${URI_BASE}/${P}.tar.gz"
HOMEPAGE="${URI_BASE}/dns.htm"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND="sys-apps/sed 
		virtual/libc"
RDEPEND="virtual/libc 
		sys-apps/ed" # dnstouch calls ed to do the dirty work

src_unpack() {
	unpack ${A}

	cd ${S}/src
	# use the correct compiler
	sed -e 's|gcc|$(CXX)|g' -i Makefile
	# set correct config pathes
	sed -e 's|#define CONFIG_PATH "/etc/"|#define CONFIG_PATH "/etc/bind/"|g' -i ndu.cpp
	sed -e 's|"/etc/ndu.conf"|"/etc/bind/ndu.conf"|g' -i dnstouch.cpp
	# hack up something to work around bug #73858
	sed -e 's|execlp("ed", "ed", filename, 0);|execlp("ed", "ed", "-s", filename, 0);|g' -i dnstouch.cpp
	# use the correct editor
	sed -e 's|VISUAL|EDITOR|g' -i dnsedit

	cd ${S}
	# match our bind config
	sed -e 's|0.0.127.in-addr.arpa|127.in-addr.arpa|g' -i ndu.conf
	# document the support for the chrooted BIND setup
	echo '// if you use a chrooted setup, then you need to uncomment these lines:' >>ndu.conf
	echo '//process "/chroot/dns/named.conf"' >>ndu.conf
	echo '//chroot "/chroot/dns"' >>ndu.conf
}

src_compile() {
	cd ${S}/src
	emake CFLAGS="${CFLAGS}" CXX="$(tc-getCXX)"
}

src_install () {
	into /usr
	dosbin src/{dnsedit,ndu}
	dobin src/dnstouch
	into /
	insinto /etc/bind
	doins ndu.conf
	dodoc README INSTALL
}
