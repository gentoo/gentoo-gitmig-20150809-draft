# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-irc/epic4/epic4-1.1.7.ebuild,v 1.6 2003/03/24 09:37:23 aliz Exp $

IUSE="ipv6 perl ssl"

DESCRIPTION="Epic4 IRC Client"
SRC_URI="ftp://prbh.org/pub/epic/EPIC4-ALPHA/${P}.tar.bz2
	 ftp://prbh.org/pub/epic/EPIC4-BETA/epic4pre2-help.tar.gz"
HOMEPAGE="http://epicsol.org"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~ppc"

DEPEND=">=sys-libs/ncurses-5.2
	perl? ( >=dev-lang/perl-5.6.1 )
	ssl? ( >=dev-libs/openssl-0.9.5 )"

inherit flag-o-matic
replace-flags -O[3-9] -O2

src_compile() {
	myconf=""

	use ipv6 \
		&& myconf="${myconf} --with-ipv6" \
		|| myconf="${myconf} --without-ipv6"
	
	use perl \
		&& myconf="${myconf} --with-perl" \
		|| myconf="${myconf} --without-perl"
	
	use ssl \
		&& myconf="${myconf} --with-ssl" \
		|| myconf="${myconf} --without-ssl"

	econf \
		--libexecdir=/usr/lib/misc \
		${myconf} || die
	
	make || die
}

src_install () {
	einstall \
		sharedir=${D}/usr/share \
		libexecdir=${D}/usr/lib/misc || die

	rm -f ${D}/usr/bin/epic
	dosym epic-EPIC4-${PV} /usr/bin/epic
	
	dodoc BUG_FORM COPYRIGHT README KNOWNBUGS VOTES
	docinto doc
	cd doc
	dodoc *.txt colors EPIC* IRCII_VERSIONS local_vars missing new-load
	dodoc nicknames outputhelp server_groups SILLINESS TS4
	
	dodir /usr/share/epic
	tar zxvf ${DISTDIR}/epic4pre2-help.tar.gz -C ${D}/usr/share/epic
}

