# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/crm114/crm114-20040212.ebuild,v 1.1 2004/03/22 10:29:09 seemant Exp $

IUSE="nls"

MY_P=${PN}-20040212-BlameJetlag.src
S=${WORKDIR}/${MY_P}
DESCRIPTION="A powerful text processing tools, mainly used for spam filtering"
HOMEPAGE="http://crm114.sourceforge.net/"
SRC_URI="mirror://sourceforge/crm114/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND=">=sys-apps/sed-4
	virtual/glibc"

src_unpack() {
	unpack ${A}

	cd ${S}
	ln -s ${S}/tre-0.6.4/lib tre
	sed -i \
		-e "s#^CFLAGS.*#CFLAGS+=${CFLAGS} -I.#" \
		-e "s#-ltre#-Ltre-0.6.4/lib/.libs -ltre#g" \
		-e "s#-static##g" \
		Makefile

	cd ${S}/tre-0.6.4
	chmod +x configure
}

src_compile() {
	# Build TRE library.
	cd ${S}/tre-0.6.4
	econf `use_enable nls` \
		--disable-profile \
		--disable-agrep \
		--enable-system-abi \
		--disable-shared \
		--disable-debug \
		--enable-static || die
	emake || die

	# Build crm114
	cd ${S}
	emake || die
}

src_install() {
	cd ${S}
	dobin crm114 cssutil cssdiff cssmerge

	dodoc COLOPHON.txt CRM114_Mailfilter_HOWTO.txt FAQ.txt INTRO.txt
	dodoc QUICKREF.txt classify_details.txt inoc_passwd.txt
	dodoc knownbugs.txt things_to_do.txt README

	mkdir ${D}/usr/share/${PN}
	cp -a *.crm ${D}/usr/share/${PN}
}

pkg_postinst() {
	echo
	einfo "The spam-filter CRM files are installed in /usr/share/${PN}."
	echo
}
