# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/crm114/crm114-20040601.ebuild,v 1.13 2007/07/12 04:37:47 mr_bones_ Exp $

inherit eutils

IUSE="emacs nls static"

MY_P=${P}-BlameKyoto.src
S=${WORKDIR}/${MY_P}
DESCRIPTION="A powerful text processing tool, mainly used for spam filtering"
HOMEPAGE="http://crm114.sourceforge.net/"
SRC_URI="http://crm114.sourceforge.net/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

TREVERS="0.6.8"

DEPEND=">=sys-apps/sed-4
	virtual/libc
	mail-filter/procmail
	emacs? ( app-emacs/mew )
	!emacs? ( net-mail/metamail )
	!static? ( >=dev-libs/tre-${TREVERS} )"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i "s#^CFLAGS.*#CFLAGS+=${CFLAGS} -I.#" Makefile

	if use static ; then
		sed -i "s#-ltre#-L${S}/${TREVERS}/lib/.libs/ -ltre#g" Makefile
	else
		sed -i "s#-static##g"  Makefile
	fi

	epatch ${FILESDIR}/${P}-mailfilter.patch

	cd ${S}/tre-${TREVERS}
	chmod +x configure
}

src_compile() {
	# Build TRE library.
	if use static ; then
		cd ${S}/tre-${TREVERS}
	    econf \
			`use_enable nls` \
			`use_enable static` \
			--enable-system-abi \
			--disable-profile \
			--disable-agrep \
			--disable-debug || die
		emake || die
	fi

	# Build crm114
	cd ${S}
	emake || die
}

src_install() {
	cd ${S}
	dobin crm114 cssutil cssdiff cssmerge
	dosym crm114 /usr/bin/crm

	dodoc COLOPHON.txt CRM114_Mailfilter_HOWTO.txt FAQ.txt INTRO.txt
	dodoc QUICKREF.txt classify_details.txt inoc_passwd.txt
	dodoc knownbugs.txt things_to_do.txt README

	mkdir ${D}/usr/share/${PN}
	cp -a *.crm ${D}/usr/share/${PN}
	cp -a *.cf ${D}/usr/share/${PN}
	cp -a *.mfp ${D}/usr/share/${PN}
}

pkg_postinst() {
	echo
	elog "The spam-filter CRM files are installed in /usr/share/${PN}."
	echo
}
