# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/crm114/crm114-20030920.ebuild,v 1.3 2004/03/22 10:29:09 seemant Exp $

IUSE="nls"

MY_P=${PN}-2003-09-20-Beta.src
S=${WORKDIR}/${MY_P}
DESCRIPTION="A powerful text processing tools, mainly used for spam filtering"
HOMEPAGE="http://crm114.sourceforge.net/"
SRC_URI="mirror://sourceforge/crm114/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND=">=sys-apps/sed-4
	virtual/glibc"

src_compile() {
	# Build TRE library.
	cd ${S}/tre-0.5.3
	# FIXME: for some reason, the configure script doesn't use
	# our CFLAGS!
	econf `use_enable nls` \
	    --disable-profile \
	    --disable-agrep \
	    --enable-system-abi \
	    --disable-shared \
	    --disable-debug \
	    --enable-static || die

	emake

	# Build crm114
	cd ${S}
	sed -i \
		-e "s#^CFLAGS=.*#CFLAGS=${CFLAGS}#" \
	    -e "s#-ltre#-Ltre-0.5.3/lib/.libs -ltre#g" \
	    -e "s#-static##g" \
	    Makefile

	emake || die
}

src_install() {
	cd ${S}
	dobin crm114 cssutil cssdiff cssmerge
	dodoc CRM114_Mailfilter_HOWTO.txt classify_details.txt
	dodoc colophon.txt faq.txt intro.txt knownbugs.txt
	dodoc quickref.txt things_to_do.txt
}
