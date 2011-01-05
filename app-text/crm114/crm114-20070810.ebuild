# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/crm114/crm114-20070810.ebuild,v 1.7 2011/01/05 17:38:34 jlec Exp $

inherit eutils

MY_P="${P}-BlameTheSegfault.src"

DESCRIPTION="A powerful text processing tool, mainly used for spam filtering"
HOMEPAGE="http://crm114.sourceforge.net/"
SRC_URI="http://crm114.sourceforge.net/tarballs/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"
IUSE="nls static normalizemime mew mimencode test"

RDEPEND="
	dev-libs/tre
	sys-apps/sed
	mew? ( app-emacs/mew )
	mimencode? ( net-mail/metamail )
	normalizemime? ( mail-filter/normalizemime )"
DEPEND="${RDEPEND}
	test? ( sys-apps/miscfiles )"

S="${WORKDIR}"/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed \
		-e "s#^CFLAGS.*#CFLAGS+=${CFLAGS}#" \
		-e "s#^LDFLAGS.*#LDFLAGS+=${LDFLAGS}#" \
		-i Makefile || die
	if use static ; then
		sed -i "s#-ltre#-L${S}/tre-${TREVERS}/lib/.libs/ -ltre#g" Makefile || die
	else
		sed -i "s#-static##g"  Makefile || die
	fi
	sed -i "s#ln -f -s crm114_tre crm114##" Makefile || die

	if use mimencode ; then
		einfo "Using mimencode -- adjusting mailfilter.cf"
		sed -i 's%#:mime_decoder: /mimencode -u/%:mime_decoder: /mimencode -u/%' \
			mailfilter.cf || die
		sed -i 's%:mime_decoder: /mewdecode/%#:mime_decoder: /mewdecode/%' \
			mailfilter.cf || die
	elif use normalizemime ; then
		einfo "Using normalizemime -- adjusting mailfilter.cf"
		sed -i 's%#:mime_decoder: /normalizemime/%:mime_decoder: /normalizemime/%' mailfilter.cf || die

		sed -i 's%:mime_decoder: /mewdecode/%#:mime_decoder: /mewdecode/%' \
			mailfilter.cf || die
	fi

}

src_compile() {
	emake -j1 || die
}

src_install() {
	dobin crm114 cssutil cssdiff cssmerge || die
	dobin cssutil cssdiff cssmerge || die
	dobin osbf-util || die

	dodoc COLOPHON.txt CRM114_Mailfilter_HOWTO.txt FAQ.txt INTRO.txt || die
	dodoc QUICKREF.txt classify_details.txt inoc_passwd.txt || die
	dodoc knownbugs.txt things_to_do.txt README || die
	docinto examples
	dodoc *.example || die

	insinto /usr/share/${PN}
	doins *.crm || die
	doins *.cf || die
	doins *.mfp || die
}

src_test() {
	emake megatest || die
}

pkg_postinst() {
	elog "The spam-filter CRM files are installed in /usr/share/${PN}."
}
