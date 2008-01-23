# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/crm114/crm114-20070810.ebuild,v 1.2 2008/01/23 18:25:23 mr_bones_ Exp $

inherit eutils
IUSE="nls static normalizemime mew mimencode test"

MY_P="${P}-BlameTheSegfault.src"
S=${WORKDIR}/${MY_P}
DESCRIPTION="A powerful text processing tool, mainly used for spam filtering"
HOMEPAGE="http://crm114.sourceforge.net/"
SRC_URI="http://crm114.sourceforge.net/tarballs/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"

TREVERS="0.7.5"

DEPEND=">=sys-apps/sed-4
	virtual/libc
	normalizemime? ( mail-filter/normalizemime )
	mew? ( app-emacs/mew )
	mimencode? ( net-mail/metamail )
	>=dev-libs/tre-${TREVERS}
	test? ( sys-apps/miscfiles )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i "s#^CFLAGS.*#CFLAGS+=${CFLAGS}#" Makefile
	sed -i "s#^LDFLAGS.*#LDFLAGS+=${LDFLAGS}#" Makefile
	if use static ; then
		sed -i "s#-ltre#-L${S}/tre-${TREVERS}/lib/.libs/ -ltre#g" Makefile
	else
		sed -i "s#-static##g"  Makefile
	fi
	sed -i "s#ln -f -s crm114_tre crm114##" Makefile

	if use mimencode ; then
		einfo "Using mimencode -- adjusting mailfilter.cf"
		sed -i 's%#:mime_decoder: /mimencode -u/%:mime_decoder: /mimencode -u/%' \
			mailfilter.cf
		sed -i 's%:mime_decoder: /mewdecode/%#:mime_decoder: /mewdecode/%' \
			mailfilter.cf
	elif use normalizemime ; then
		einfo "Using normalizemime -- adjusting mailfilter.cf"
		sed -i 's%#:mime_decoder: /normalizemime/%:mime_decoder: /normalizemime/%' mailfilter.cf

		sed -i 's%:mime_decoder: /mewdecode/%#:mime_decoder: /mewdecode/%' \
			mailfilter.cf
	fi

}

src_compile() {
	emake -j1 || die
}

src_install() {
	dobin crm114 cssutil cssdiff cssmerge
	dobin cssutil cssdiff cssmerge
	dobin osbf-util

	dodoc COLOPHON.txt CRM114_Mailfilter_HOWTO.txt FAQ.txt INTRO.txt
	dodoc QUICKREF.txt classify_details.txt inoc_passwd.txt
	dodoc knownbugs.txt things_to_do.txt README
	docinto examples
	dodoc *.example

	insinto /usr/share/${PN}
	doins *.crm
	doins *.cf
	doins *.mfp
}

src_test() {
	make megatest
}

pkg_postinst() {
	einfo ""
	einfo "The spam-filter CRM files are installed in /usr/share/${PN}."
	einfo ""
}
