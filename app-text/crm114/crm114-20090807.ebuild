# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/crm114/crm114-20090807.ebuild,v 1.1 2009/12/25 03:13:41 darkside Exp $

EAPI=2
MY_P="${P}-BlameThorstenAndJenny.src"
S=${WORKDIR}/${MY_P}

inherit eutils toolchain-funcs

DESCRIPTION="A powerful text processing tool, mainly used for spam filtering"
HOMEPAGE="http://crm114.sourceforge.net/"
SRC_URI="http://crm114.sourceforge.net/tarballs/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE="mew mimencode nls normalizemime +static test"

RDEPEND="normalizemime? ( mail-filter/normalizemime )
	mew? ( app-emacs/mew )
	mimencode? ( net-mail/metamail )
	>=dev-libs/tre-0.7.5"
DEPEND="${RDEPEND}
	test? ( sys-apps/miscfiles )"

src_prepare() {
	sed -i "s#^CFLAGS += -O3 -Wall##" Makefile || die
	sed -i "s#^CC=.*#CC=$(tc-getCC)#" Makefile || die
	# Upstream recommends static linking
	if ! use static ; then
		sed -i "s#LDFLAGS += -static -static-libgcc#LDFLAGS += ${LDFLAGS}#"	Makefile || die
	else
		sed -i "s#LDFLAGS += -static -static-libgcc#LDFLAGS += ${LDFLAGS} \
		 -static -static-libgcc#"  Makefile || die
	fi

	if use mimencode ; then
		sed -i -e 's%#:mime_decoder: /mimencode -u/%:mime_decoder: /mimencode -u/%' \
		-e 's%:mime_decoder: /mewdecode/%#:mime_decoder: /mewdecode/%' \
			mailfilter.cf || die
	elif use normalizemime ; then
		sed -i -e 's%#:mime_decoder: /normalizemime/%:mime_decoder: /normalizemime/%' \
		-e 's%:mime_decoder: /mewdecode/%#:mime_decoder: /mewdecode/%' \
			mailfilter.cf || die
	fi

}

src_install() {
	dobin crm114 cssutil cssdiff cssmerge || die
	dobin cssutil cssdiff cssmerge || die
	dobin osbf-util || die

	dodoc COLOPHON.txt CRM114_Mailfilter_HOWTO.txt FAQ.txt INTRO.txt || die
	dodoc QUICKREF.txt CLASSIFY_DETAILS.txt inoc_passwd.txt || die
	dodoc KNOWNBUGS.txt THINGS_TO_DO.txt README || die
	docinto examples
	dodoc *.example || die

	insinto /usr/share/${PN}
	doins *.crm || die
	doins *.cf || die
	doins *.mfp || die
}

src_test() {
	emake megatest
}

pkg_postinst() {
	elog "The spam-filter CRM files are installed in /usr/share/${PN}."
}
